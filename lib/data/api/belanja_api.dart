import 'package:dio/dio.dart';
import 'package:flutter_crud_api/data/model/product.dart';

class BelanjaApi {
  static final BelanjaApi _instance = BelanjaApi._internal();

  factory BelanjaApi() {
    return _instance;
  }

  Dio get _dio {
    final dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options) {
        print('---REQUEST---');
        print(options.toString());
        print('---REQUEST---');
      },
      onResponse: (e) {
        print('---RESPONSE---');
        print(e.toString());
        print('---RESPONSE---');
      },
      onError: (e) {
        print('---ERROR---');
        print(e.toString());
        print('---ERROR---');
      },
    ));

    return dio;
  }

  String get _baseUrl => const String.fromEnvironment("BASE_URL_API");

  BelanjaApi._internal();

  Future<List<Product>> getProducts() async {
    try {
      final Response response = await _dio.get("$_baseUrl/products");
      final results = Map<String, dynamic>.from(response.data);
      return (results['data'] as List)
          .map((e) => Product.fromMap(e))
          .toList(growable: false);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final Response response = await _dio.get("$_baseUrl/products/$id");
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results['data']);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> postProducts(body) async {
    try {
      final Response response = await _dio.post(
        "$_baseUrl/products",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results['data']);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Product> putProductById(id, body) async {
    try {
      final Response response = await _dio.put(
        "$_baseUrl/products/$id",
        data: body,
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      final results = Map<String, dynamic>.from(response.data);
      return Product.fromMap(results['data']);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> deleteProductById(id) async {
    try {
      final Response response = await _dio.delete("$_baseUrl/products/$id");
      final resutls = Map<String, dynamic>.from(response.data);
      return response.statusCode == 200;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
