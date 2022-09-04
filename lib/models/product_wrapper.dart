import 'package:nutri_plus/models/product.dart';

class ProductWrapper {
  String? code;
  Product? product;
  int? status;
  String? status_verbose;

  ProductWrapper({this.code, this.product, this.status, this.status_verbose});

  ProductWrapper.fromMappedJson(Map<String, dynamic> json) :
        this.code = json['code'] as String,
        this.product = Product.fromMappedJson(json['product'] ?? {});

}