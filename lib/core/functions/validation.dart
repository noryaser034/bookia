bool isEmailValid(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

String? validateEgyptPhone(String? value) {
  final regex = RegExp(r'^01[0125][0-9]{8}$');

  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid Egyptian mobile number';
  }
  return null;
}
