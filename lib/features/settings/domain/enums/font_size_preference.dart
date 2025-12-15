
enum FontSizePreference {

  small,

  medium,

  large;

  static FontSizePreference fromString(String fontSize) {
    switch (fontSize) {
      case 'small':
        return FontSizePreference.small;
      case 'medium':
        return FontSizePreference.medium;
      case 'large':
        return FontSizePreference.large;
      default:
        return FontSizePreference.medium;
    }
  }
}
