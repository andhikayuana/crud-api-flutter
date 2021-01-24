import 'package:flutter/material.dart';
import 'package:flutter_crud_api/data/api/belanja_api.dart';
import 'package:flutter_crud_api/data/model/product.dart';

//callback
typedef OnDeletedProduct = Function();
typedef OnEditProduct = Function(Product product);
typedef OnTapProduct = Function(Product product);

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    @required this.onEditProduct,
    @required this.onDeletedProduct,
    @required this.onTapProduct,
  }) : super(key: key);

  final Product product;
  final OnEditProduct onEditProduct;
  final OnDeletedProduct onDeletedProduct;
  final OnTapProduct onTapProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onTapProduct(product);
        },
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(product.name),
              subtitle: Text(
                "Rp ${product.price.toString()}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: () {
                    onEditProduct(product);
                  },
                  child: const Text('Edit'),
                ),
                FlatButton(
                  onPressed: () {
                    final dialog = AlertDialog(
                      title: Text('Delete Product?'),
                      content: Text('This will delete your product.'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            try {
                              final bool deleted = await BelanjaApi()
                                  .deleteProductById(product.id);
                              if (deleted) {
                                onDeletedProduct();
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          child: Text('ACCEPT'),
                        ),
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (context) => dialog,
                    );
                  },
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
