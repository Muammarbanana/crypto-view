import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/features/features.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void init() {
  di
    // Remote Datasources
    ..registerFactory<CryptoWatchlistRemoteDatasource>(
      CryptoWatchlistRemoteDatasource.new,
    )

    // Repository
    ..registerFactory<CryptoWatchlistRepository>(
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
    ..registerLazySingleton(
      CryptoChartCubit.new,
    )
    ..registerLazySingleton(
      CustomThemeCubit.new,
    );
}
