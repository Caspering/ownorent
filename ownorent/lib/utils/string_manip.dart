extension StringExtensions on String {
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : this;
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach =>
      split(' ').map((str) => str.capitalize).join(' ');
}
