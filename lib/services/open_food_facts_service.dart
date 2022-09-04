import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_wrapper.dart';

class OpenFoodFactsService {

  String _uriPart = 'https://world.openfoodfacts.org/api/v0/product/';
  String _code = '';

  OpenFoodFactsService(code) {
    this._code = code;
  }

  Future<ProductWrapper?> fetchApi() async {
    ProductWrapper? product;
    Uri uri = Uri.parse(_uriPart + _code + '.json');

    await http.get(uri).then((response) {
      Map<String, dynamic> parsed = jsonDecode(response.body);
      if(parsed['status_verbose'] != 'product not found') {
        product = ProductWrapper.fromMappedJson(parsed);
      } else {
        return null;
      }
    });

    return product;
  }

}