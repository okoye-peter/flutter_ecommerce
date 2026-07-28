// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductAttributeModel {
  String? name;
  List<String>? values;

  ProductAttributeModel({this.name, this.values});

  Map<String, dynamic> toJson() {
    return {
      'Name': name ?? '',
      'values': values ?? {},
    };
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;

    if (data.isEmpty) return ProductAttributeModel();
    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: List<String>.from(data['Values']),
    );
  }
}
