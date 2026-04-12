/// Network response wrapper.
/// Canonical location: `package:bookia/core/network/base_response.dart`
class BaseResponse {
  dynamic data;
  String? message;
  List<dynamic>? error;
  int? status;

  BaseResponse({this.data, this.message, this.error, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      data: json['data'],
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data,
    'message': message,
    'error': error,
    'status': status,
  };
}
