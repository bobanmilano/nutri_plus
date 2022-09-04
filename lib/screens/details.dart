import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetails extends StatefulWidget {
  final Product? product;

  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product? _product;

  void initState() {
    _product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
