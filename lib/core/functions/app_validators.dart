abstract class AppValidators {
  AppValidators._(); // يمنع إنشاء object بالغلط

  // ------------------- Regex -------------------
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}$',
  );

  static final RegExp _nameRegex = RegExp(
    r"^[a-zA-Z\s'-]+$",
  ); // ✅ لاحظ: \s بدل s

  static final RegExp _egyNumberRegex = RegExp(r'^01[0125][0-9]{8}$');

  static final RegExp _phoneRegex = RegExp(r'^[0-9]{8,15}$');

  // ------------------- Checks -------------------
  static bool isEmailValid(String email) => _emailRegex.hasMatch(email);

  static bool isPasswordValid(String password) =>
      _passwordRegex.hasMatch(password);

  static bool isNameValid(String name) => _nameRegex.hasMatch(name);

  static bool isEgyNumberValid(String number) =>
      _egyNumberRegex.hasMatch(number);

  // ------------------- Validators -------------------
  static String? email(String? input, {required String emptyMessage, required String invalidMessage}) {
    final value = input?.trim() ?? '';
    if (value.isEmpty) return emptyMessage;
    if (!isEmailValid(value)) return invalidMessage;
    return null;
  }

  static String? name(String? input, {required String emptyMessage, required String invalidMessage}) {
    final value = input?.trim() ?? '';
    if (value.isEmpty) return emptyMessage;
    if (value.length < 3 || !isNameValid(value)) {
      return invalidMessage;
    }
    return null;
  }

  static String? Function(String?) password({
    required String emptyMessage,
    required String invalidMessage,
  }) {
    return (String? input) {
      final value = input?.trim() ?? '';
      if (value.isEmpty) return emptyMessage;
      if (!isPasswordValid(value)) {
        return invalidMessage;
      }
      return null;
    };
  }

  static String? Function(String?) confirmPassword({
    required String Function() passwordProvider,
    required String emptyMessage,
    required String invalidMessage,
  }) {
    return (String? input) {
      final confirm = input?.trim() ?? '';
      final password = passwordProvider().trim();

      if (confirm.isEmpty) return emptyMessage;
      if (confirm != password) return invalidMessage;
      return null;
    };
  }

  static String? address(String? input, {required String emptyMessage, required String invalidMessage}) {
    final value = input?.trim() ?? '';
    if (value.isEmpty) return emptyMessage;
    if (value.length < 5) return invalidMessage;
    return null;
  }

  static String? phone(String? input, {required String emptyMessage, required String invalidMessage}) {
    final value = input?.trim() ?? '';
    if (value.isEmpty) return emptyMessage;
    if (!_phoneRegex.hasMatch(value)) {
      return invalidMessage;
    }
    return null;
  }
}
