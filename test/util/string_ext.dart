extension StringExt on String {
  String trimSpace() => replaceAll(RegExp(r'\s'), '');
}
