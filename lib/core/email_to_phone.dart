String emailToPhone(String email) {
  List<String> list = email.split('@');
  return list[0];
}
