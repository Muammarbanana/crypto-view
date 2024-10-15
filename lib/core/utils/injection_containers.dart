import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/features/features.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void init() {
  di
    // Remote Datasources
    ..registerLazySingleton<CryptoWatchlistRemoteDatasource>(
      CryptoWatchlistRemoteDatasource.new,
    )

    // Repository
    ..registerLazySingleton<CryptoWatchlistRepository>(
      () => CryptoWatchlistRepositoryImpl(
        dataSource: di(),
      ),
    )

    // Blocs
    ..registerFactory(
      () => CryptoWatchlistBloc(
        repository: di(),
      ),
    )
    ..registerFactory(
      CustomThemeCubit.new,
    );
}
