import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_api/data/model/product.dart';

class DetailScreen extends StatelessWidget {
  static const String route = "/detail";

  const DetailScreen({
    Key key,
    this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 24),
              ),
              Text(
                "Rp ${product.price.toString()}",
                style: TextStyle(fontSize: 18),
              ),
              CachedNetworkImage(imageUrl: product.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}
