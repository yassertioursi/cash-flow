import 'package:cashflow/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../features/settings/domain/enums/currency_format.dart';

class AppFormatters {

  static String formatCurrencyWithPreference(double value, CurrencyFormat format, String locale) {
    final formatter = NumberFormat.simpleCurrency(locale: locale);

    if (format == CurrencyFormat.code) {

      final valueOnly = formatter.format(value).replaceAll(formatter.currencySymbol, '').trim();
      return '$valueOnly ${formatter.currencyName ?? 'USD'}';
    }

    return formatter.format(value);
  }

  static String formatCurrency(double value, String locale, {bool noSymbol = false}) {
    final format = NumberFormat.simpleCurrency(locale: locale);
    if (noSymbol) {
      return format.format(value).replaceAll(format.currencySymbol, '').trim();
    }
    return format.format(value);
  }

  static String formatDateShort(DateTime date, String locale) {
    return DateFormat.Md(locale).format(date);
  }

  static double getCurrencyValue(String formatted, String locale) {
    final format = NumberFormat.simpleCurrency(locale: locale);
    String cleaned = formatted.replaceAll(format.currencySymbol, '').trim();
    cleaned = cleaned.replaceAll(format.symbols.GROUP_SEP, '');
    cleaned = cleaned.replaceAll(format.symbols.DECIMAL_SEP, '.');
    return double.tryParse(cleaned) ?? 0.0;
  }

  static final DateFormat dateOnlyFormatter = DateFormat('yyyy-MM-dd');
  static final DateFormat fullDateFormatter = DateFormat.yMMMMd();

  static final DateFormat weekdayDateFormatter = DateFormat('EEEE, MMM d');

  static String formatWeekdayDate(DateTime date, String locale) {
    return DateFormat('EEEE, MMM d', locale).format(date);
  }

  static String currencySymbol(String locale) {
    return NumberFormat.simpleCurrency(locale: locale).currencySymbol;
  }

  static TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String formatTimeOfDay(TimeOfDay reminderTime) {
    final hour = reminderTime.hour.toString().padLeft(2, '0');
    final minute = reminderTime.minute.toString().padLeft(2, '0');
    final result = '$hour:$minute';
    return result;
  }

  static DateTime? parseDate(String text, AppLocalizations loc) {
    try {
      return dateOnlyFormatter.parseStrict(text);
    } catch (e) {
      return null;
    }
  }

  static const Map<String, PhoneFormatConfig> _phoneFormats = {
    'en': PhoneFormatConfig(
      countryCode: '1',
      pattern: '(XXX) XXX-XXXX',
      maxDigits: 10,
    ),
    'fr': PhoneFormatConfig(
      countryCode: '33',
      pattern: '(XX) XX XX XX XX',
      maxDigits: 10,
    ),
  };

  static String getPhoneCountryCode(String locale) {
    final langCode = locale.split('_').first;
    return _phoneFormats[langCode]?.countryCode ?? _phoneFormats['en']!.countryCode;
  }

  static String getPhoneFormatPattern(String locale) {
    final langCode = locale.split('_').first;
    return _phoneFormats[langCode]?.pattern ?? _phoneFormats['en']!.pattern;
  }

  static int getPhoneMaxDigits(String locale) {
    final langCode = locale.split('_').first;
    return _phoneFormats[langCode]?.maxDigits ?? _phoneFormats['en']!.maxDigits;
  }

  static String getAddressFormatHint(AppLocalizations loc) {
    return loc.hintAddressFormat;
  }
}

class PhoneFormatConfig {
  final String countryCode;
  final String pattern;
  final int maxDigits;

  const PhoneFormatConfig({
    required this.countryCode,
    required this.pattern,
    required this.maxDigits,
  });
}

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter;

  CurrencyInputFormatter({String? locale})
      : _formatter = NumberFormat.currency(
          locale: locale,
          symbol: '',
          decimalDigits: 2,
        );

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    double value = double.parse(newText) / 100;
    String formattedText = _formatter.format(value).trim();

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
