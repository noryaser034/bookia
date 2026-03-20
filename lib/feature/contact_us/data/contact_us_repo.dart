import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';

class ContactUsRepo {
  static Future<void> sendMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final token = SharedPref.getToken();
    await DioProvider.post(
      endpoint: Apis.contactUs,
      headers: {'Authorization': 'Bearer $token'},
      data: {
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
      },
    );
  }
}