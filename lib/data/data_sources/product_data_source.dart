import 'dart:convert';

import 'package:footloose_app/core/error/exceptions.dart';
import 'package:footloose_app/core/request_builder.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/models/shopping_cart.dart';
import 'package:footloose_app/domain/models/size.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
  Future<List<Brand>> getBrands();
  Future<List<Model>> getModels();
  Future<List<Color>> getColors();
  Future<List<Size>> getSizes();
  Future<Product> getProduct(int id);
  Future<bool> saveShoppingCart(List<ShoppingCartProduct> products);
}

class ProductDataSourceImpl implements ProductDataSource {
  const ProductDataSourceImpl({
    required this.requestBuilder,
  });
  final RequestBuilder requestBuilder;

  @override
  Future<List<Product>> getProducts() async {
    const endpoint = '/api/producto/list';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final products = productFromJson(response.body);
      return products;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<Brand>> getBrands() async {
    const endpoint = '/api/marca/list';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final brands = brandFromJson(response.body);
      return brands;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<Model>> getModels() async {
    const endpoint = '/api/modelo/list';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final models = modelFromJson(response.body);
      return models;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<Color>> getColors() async {
    const endpoint = '/api/color/list';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final colors = colorFromJson(response.body);
      return colors;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<Size>> getSizes() async {
    const endpoint = '/api/talla/list';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final sizes = sizeFromJson(response.body);
      return sizes;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    final endpoint = '/api/producto/show/$id';

    final response = await requestBuilder.request(
      endpoint,
      RequestType.get,
      withAuthentication: true,
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final product = Product.fromJson(body as Map<String, dynamic>);
      return product;
    } else {
      throw RequestException();
    }
  }

  @override
  Future<bool> saveShoppingCart(List<ShoppingCartProduct> products) async {
    const endpoint = '/api/carrito/add';

    final items = <Map<String, dynamic>>[];

    for (final product in products) {
      items.add({
        'idProducto': product.product.idProducto,
        'cantidad': product.total,
        'precio': product.product.precioProducto
      });
    }

    final body = {'idUsuario': '1', 'productos': items};

    final response = await requestBuilder.request(
      endpoint,
      RequestType.post,
      withAuthentication: true,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw RequestException();
    }
  }
}
