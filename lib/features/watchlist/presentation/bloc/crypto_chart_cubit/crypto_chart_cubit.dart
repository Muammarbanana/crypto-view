import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoChartCubit extends Cubit<String> {
  CryptoChartCubit() : super('BTC-USD');

  void selectCryptoAsset(String symbol) {
    emit(symbol);
  }
}
