class Registerparams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;

  Registerparams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (name != null) data['name'] = name;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (passwordConfirmation != null) {
      data['password_confirmation'] = passwordConfirmation;
    }

    return data;
  }
}
