String capitalize(String s) {
  if (s.isEmpty) {
    return s;
  } else if (s.length == 1) {
    return s.toUpperCase();
  }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
