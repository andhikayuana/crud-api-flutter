import 'package:flutter/material.dart';
import 'package:flutter_crud_api/data/api/belanja_api.dart';
import 'package:flutter_crud_api/data/model/product.dart';
import 'package:flutter_crud_api/screen/detail/detail_screen.dart';
import 'package:flutter_crud_api/screen/form/form_screen.dart';
import 'package:flutter_crud_api/widget/product_card.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/";

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Product>> _products;
  List<Product> _productsList;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _products = BelanjaApi().getProducts();
    _productsList = List<Product>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CRUD API Demo"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _products = BelanjaApi().getProducts();
          });
        },
        child: FutureBuilder(
          future: _products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (_productsList.length == 0) {
                //add data for first time
                _productsList = (snapshot.data as List).toList(growable: true);
              }
              return ListView.builder(
                controller: _scrollController,
                itemCount: _productsList.length,
                itemBuilder: (context, index) => ProductCard(
                  product: _productsList[index],
                  onTapProduct: (product) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            product: product,
                          ),
                        ));
                  },
                  onEditProduct: (product) async {
                    final Product product = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormScreen(
                            isAddNew: false,
                            product: _productsList[index],
                          ),
                        ));
                    setState(() {
                      _productsList[index] = product;
                    });
                  },
                  onDeletedProduct: () {
                    setState(() {
                      _productsList.removeAt(index);
                    });
                  },
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Product product = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormScreen(isAddNew: true),
              ));
          if (product != null) {
            setState(() {
              _productsList.add(product);
            });
          }

          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
        elevation: 2.0,
        child: Icon(Icons.add),
      ),
    );
  }
}
