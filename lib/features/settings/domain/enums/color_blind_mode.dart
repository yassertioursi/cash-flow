
enum ColorBlindMode {

  none,

  protanopia,

  deuteranopia,

  tritanopia;

  static ColorBlindMode fromString(String colorBlindMode) {
    switch (colorBlindMode) {
      case 'protanopia':
        return ColorBlindMode.protanopia;
      case 'deuteranopia':
        return ColorBlindMode.deuteranopia;
      case 'tritanopia':
        return ColorBlindMode.tritanopia;
      case 'none':
      default:
        return ColorBlindMode.none;
    }
  }
}
