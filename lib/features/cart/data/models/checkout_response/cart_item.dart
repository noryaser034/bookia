class CartItem {
  int? itemId;
  int? itemProductId;
  String? itemProductName;
  String? itemProductPrice;
  int? itemQuantity;
  String? itemTotal;

  CartItem({
    this.itemId,
    this.itemProductId,
    this.itemProductName,
    this.itemProductPrice,
    this.itemQuantity,
    this.itemTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    itemId: json['item_id'] as int?,
    itemProductId: json['item_product_id'] as int?,
    itemProductName: json['item_product_name'] as String?,
    itemProductPrice: json['item_product_price'] as String?,
    itemQuantity: json['item_quantity'] as int?,
    itemTotal: json['item_total'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'item_id': itemId,
    'item_product_id': itemProductId,
    'item_product_name': itemProductName,
    'item_product_price': itemProductPrice,
    'item_quantity': itemQuantity,
    'item_total': itemTotal,
  };
}
