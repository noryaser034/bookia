class EditProfileParams {
  String? name;
  String? address;
  String? phone;

  EditProfileParams({this.name, this.address, this.phone});

  factory EditProfileParams.fromJson(Map<String, dynamic> json) {
    return EditProfileParams(
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'phone': phone,
  };
}
