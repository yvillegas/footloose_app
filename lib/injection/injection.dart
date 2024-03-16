import 'package:footloose_app/core/request_builder.dart';
import 'package:footloose_app/data/data_sources/auth_data_source.dart';
import 'package:footloose_app/data/repositories/auth_repository_impl.dart';
import 'package:footloose_app/domain/repositories/auth_repository.dart';
import 'package:footloose_app/domain/use_cases/login_user.dart';
import 'package:footloose_app/domain/use_cases/save_user.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Use cases
  getIt.registerLazySingleton<LoginUser>(
    () => LoginUser(
      getIt<AuthRepository>(),
    ),
  );
  getIt.registerLazySingleton<SaveUser>(
    () => SaveUser(
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
      sharedPreferences: getIt<SharedPreferences>(),
    ),
  );

  // External
  getIt.registerLazySingleton(http.Client.new);
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  // Request Builder
  getIt.registerLazySingleton<RequestBuilder>(
    () => RequestBuilder(
      httpClient: getIt(),
    ),
  );
}
