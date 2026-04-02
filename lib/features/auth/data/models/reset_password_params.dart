class ResetPasswordParams {
  final String verifyCode;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordParams({
    required this.verifyCode,
    required this.confirmPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'verify_code': verifyCode,
    'new_password': newPassword,
    'new_password_confirmation': confirmPassword,
  };
}
