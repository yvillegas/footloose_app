import 'package:footloose_app/core/request_builder.dart';
import 'package:http/http.dart' as http;
import 'package:footloose_app/data/data_sources/auth_data_source.dart';
import 'package:footloose_app/data/repositories/auth_repository_impl.dart';
import 'package:footloose_app/domain/repositories/auth_repository.dart';
import 'package:footloose_app/domain/use_cases/login_user.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Use cases
  getIt.registerLazySingleton<LoginUser>(
    () => LoginUser(
      getIt<AuthRepository>(),
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: getIt<AuthDataSource>(),
    ),
  );

  // Datasource
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      requestBuilder: getIt<RequestBuilder>(),
    ),
  );

  // External
  getIt.registerLazySingleton(http.Client.new);

  // Request Builder
  getIt.registerLazySingleton<RequestBuilder>(
    () => RequestBuilder(
      httpClient: getIt(),
    ),
  );
}
