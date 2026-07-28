class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured,
    this.productsCount,
  });

  BrandModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isFeatured,
    int? productsCount,
  }) {
    return BrandModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      productsCount: productsCount ?? this.productsCount,
    );
  }

  static BrandModel empty() => BrandModel(id: '', name: '', image: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'productsCount': productsCount,
    };
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      isFeatured: map['isFeatured'] != null ? map['isFeatured'] as bool : null,
      productsCount: map['productsCount'] != null
          ? map['productsCount'] as int
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ProductsCount': productsCount,
      'IsFeatured': isFeatured,
    };
  }

  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(
      id: data['Id'], 
      name: data['Name'], 
      image: data['Image'],
      productsCount: data['ProductCount'],
      isFeatured: data['IsFeatured'],
    );
  }

  @override
  String toString() {
    return 'BrandModel(id: $id, name: $name, image: $image, isFeatured: $isFeatured, productsCount: $productsCount)';
  }

  // @override
  // bool operator ==(covariant BrandModel other) {
  //   if (identical(this, other)) return true;

  //   return other.id == id &&
  //       other.name == name &&
  //       other.image == image &&
  //       other.isFeatured == isFeatured &&
  //       other.productsCount == productsCount;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       name.hashCode ^
  //       image.hashCode ^
  //       isFeatured.hashCode ^
  //       productsCount.hashCode;
  // }
}
