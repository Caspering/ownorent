String removeCommasAndAlphabets(String str) {
  String result = '';
  for (int i = 0; i < str.length; i++) {
    if (RegExp(r'[0-9]').hasMatch(str[i])) {
      result += str[i];
    }
  }
  return result;
}
