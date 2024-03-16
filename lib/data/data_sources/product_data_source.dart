import 'package:footloose_app/core/error/exceptions.dart';
import 'package:footloose_app/core/request_builder.dart';
import 'package:footloose_app/domain/models/product.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
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
}
