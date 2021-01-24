import 'package:flutter/material.dart';
import 'package:flutter_crud_api/screen/detail/detail_screen.dart';
import 'package:flutter_crud_api/screen/form/form_screen.dart';
import 'package:flutter_crud_api/screen/home/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter CRUD API Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HomeScreen(),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context) => HomeScreen(),
        DetailScreen.route: (context) => DetailScreen(),
        FormScreen.routeAdd: (context) => FormScreen(
              isAddNew: true,
            ),
        FormScreen.routeEdit: (context) => FormScreen(
              isAddNew: false,
            ),
      },
    );
  }
}
