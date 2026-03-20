class OrderModel {
  final int id;
  final String total;
  final String createdAt;

  OrderModel({
    required this.id,
    required this.total,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      total: json['total'].toString(),
      createdAt: json['created_at'],
    );
  }
}