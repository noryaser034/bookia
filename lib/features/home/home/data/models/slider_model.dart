class SliderModel {
  final String image;

  const SliderModel({required this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(image: json["image"] ?? "");
  }
}
