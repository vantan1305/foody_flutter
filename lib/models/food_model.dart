class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;
  Product(
      {required products,
      required offset,
      required totalSize,
      required typeId}) {
    this._products = products;
    this._typeId = typeId;
    this._offset = offset;
    this._totalSize = totalSize;
  }

  Product.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];

    if (json['products'] != null) {
      _products = <ProductModel>[];
      json['products'].forEach((v) {
        _products.add(ProductModel.fromJson(v));
      });
    }
  }
}

class ProductModel {
  int? id;
  String? name;
  String? description;
  int? price;
  int? star;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.createdAt,
      this.description,
      this.id,
      this.img,
      this.location,
      this.name,
      this.price,
      this.star,
      this.typeId,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    star = json['star'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'description': this.description,
      'price': this.price,
      'star': this.star,
      'img': this.img,
      'location': this.location,
      'createdAt': this.createdAt,
      'updatedAt': this.updatedAt,
      'typeId': this.typeId
    };
  }
}
