import 'governorate.dart';

class GovernoratesResponse {
  List<Governorate>? data;

  GovernoratesResponse({this.data});

  factory GovernoratesResponse.fromJson(Map<String, dynamic> json) {
    return GovernoratesResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Governorate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
