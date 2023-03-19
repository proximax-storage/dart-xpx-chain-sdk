class Password {
  String value = '';

  constructor(String password) {
    if (password.length < 8) {
      throw new Exception('Password must be at least 8 characters');
    }
    value = password;
  }
}
