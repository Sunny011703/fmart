class ProductApiModels {
  List<FreeProductApiModel>? products;

  ProductApiModels({this.products});

  factory ProductApiModels.fromJson(List<dynamic> jsonList) {
    List<FreeProductApiModel> productList = jsonList.map((json) => FreeProductApiModel.fromJson(json)).toList();
    return ProductApiModels(products: productList);
  }
}

class FreeProductApiModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;

  FreeProductApiModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  factory FreeProductApiModel.fromJson(Map<String, dynamic> json) {
    return FreeProductApiModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] as num?)?.toDouble(),
      count: json['count'],
    );
  }
}
