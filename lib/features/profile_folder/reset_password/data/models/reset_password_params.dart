class ResetPasswordParams {
  String? currentPassword;
  String? newPassword;
  String? newPasswordConfirmation;

  ResetPasswordParams({
    this.currentPassword,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  factory ResetPasswordParams.fromJson(Map<String, dynamic> json) {
    return ResetPasswordParams(
      currentPassword: json['current_password'] as String?,
      newPassword: json['new_password'] as String?,
      newPasswordConfirmation: json['new_password_confirmation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_password': currentPassword,
    'new_password': newPassword,
    'new_password_confirmation': newPasswordConfirmation,
  };
}
