import 'package:crypto_view/features/features.dart';

abstract class CryptoWatchlistRepository {
  Stream<CryptoWebsocketResponse> get messagesStream;
  Future<void> connectToWebSocket();
  Future<void> sendMessageToWebSocket(WebSocketMessageParams params);
  Future<void> disconnectFromWebSocket();
}
