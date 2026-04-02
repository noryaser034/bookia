import 'checkout_data.dart';

class CheckoutResponse {
  CheckoutData? data;
  String? message;
  List<dynamic>? error;
  int? status;

  CheckoutResponse({this.data, this.message, this.error, this.status});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      data: json['data'] == null
          ? null
          : CheckoutData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'message': message,
    'error': error,
    'status': status,
  };
}
