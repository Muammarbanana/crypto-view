import 'package:crypto_view/features/features.dart';

class CryptoWatchlistRepositoryImpl implements CryptoWatchlistRepository {
  CryptoWatchlistRepositoryImpl({required this.dataSource});

  final CryptoWatchlistRemoteDatasource dataSource;

  @override
  Stream<CryptoWebsocketResponse> get messagesStream =>
      dataSource.messagesStream;

  @override
  Future<void> connectToWebSocket() async {
    return dataSource.connectToWebSocket();
  }

  @override
  Future<void> sendMessageToWebSocket(WebSocketMessageParams params) async {
    return dataSource.sendMessageToWebSocket(params);
  }

  @override
  Future<void> disconnectFromWebSocket() async {
    return dataSource.disconnectFromWebSocket();
  }
}
