import 'package:flutter/material.dart';
import 'package:flutter_crud_api/data/api/belanja_api.dart';
import 'package:flutter_crud_api/data/model/product.dart';
import 'package:flutter_crud_api/screen/form/form_validation.dart';

class FormScreen extends StatefulWidget {
  static const String routeAdd = "/add";
  static const String routeEdit = "/edit";
  final bool isAddNew;
  Product product;

  FormScreen({
    Key key,
    @required this.isAddNew,
    this.product,
  }) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with FormValidation {
  final formKey = GlobalKey<FormState>();

  String productName;
  int productPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isAddNew ? "Add New Product" : "Edit Product"),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context, widget.product);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState.validate()) {
                formKey.currentState.save();

                if (widget.isAddNew) {
                  BelanjaApi().postProducts({
                    "name": productName,
                    "price": productPrice,
                    "image": "https://ui-avatars.com/api/?name=$productName",
                  }).then((value) {
                    formKey.currentState.reset();
                    Navigator.pop(context, value);
                  });
                } else {
                  BelanjaApi().putProductById(widget.product.id, {
                    "name": productName,
                    "price": productPrice,
                  }).then((value) {
                    formKey.currentState.reset();
                    Navigator.pop(context, value);
                  });
                }
              }
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Product Name"),
                validator: validateProductName,
                initialValue: widget.isAddNew ? null : widget.product.name,
                onSaved: (newValue) => productName = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Product Price"),
                validator: validateProductPrice,
                initialValue:
                    widget.isAddNew ? null : widget.product.price.toString(),
                onSaved: (newValue) => productPrice = int.tryParse(newValue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
