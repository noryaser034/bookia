class GovernorateModel {
  int? id;
  String? governorateNameEn;

  GovernorateModel({this.id, this.governorateNameEn});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      GovernorateModel(
        id: json['id'] as int?,
        governorateNameEn: json['governorate_name_en'] as String?,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'governorate_name_en': governorateNameEn,
  };
}
