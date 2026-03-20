import 'package:bookia/core/services/dio/apis.dart';
import 'package:bookia/core/services/dio/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/feature/faq/data/models/faq_model.dart';

class FaqRepo {
  static Future<List<FaqModel>> getFaqs() async {
    final token = SharedPref.getToken();
    final response = await DioProvider.get(
      endpoint: Apis.faqs,
      headers: {'Authorization': 'Bearer $token'},
    );
    final faqsList = response.data['data']['faqs'] as List;
    if (faqsList.isEmpty) {
      return [
        FaqModel(
          id: 1,
          question: 'How to place an order?',
          answer:
              'You can place an order by adding books to your cart and proceeding to checkout.',
        ),
        FaqModel(
          id: 2,
          question: 'How to track my order?',
          answer:
              'You can track your order from the My Orders section in your profile.',
        ),
        FaqModel(
          id: 3,
          question: 'What payment methods are accepted?',
          answer: 'We accept cash on delivery and online payment.',
        ),
      ];
    }
    return faqsList.map((e) => FaqModel.fromJson(e)).toList();
  }
}
