import 'package:crypto_view/core/core.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

void init() {
  di
      // Remote Datasources

      // Usecases

      // Blocs

      .registerFactory(
    CustomThemeCubit.new,
  );
}
