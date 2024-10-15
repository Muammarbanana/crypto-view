import 'dart:convert';

import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoWatchlistRemoteDatasource {
  WebSocketChannel? _channel;

  Stream<CryptoWebsocketResponse> get messagesStream =>
      _channel!.stream.map((event) {
        try {
          // Decode the incoming event and convert it to MessageModel
          final jsonData = jsonDecode(event.toString()) as Map<String, dynamic>;
          return CryptoWebsocketResponse.fromJson(jsonData);
        } catch (e) {
          // Return a default model or handle errors accordingly
          rethrow;
        }
      }).throttleTime(const Duration(seconds: 1));

  Future<void> connectToWebSocket() async {
    const url = 'wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo';
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  Future<void> sendMessageToWebSocket(WebSocketMessageParams params) async {
    _channel?.sink.add(params.toJson());
  }

  Future<void> disconnectFromWebSocket() async {
    await _channel?.sink.close(status.normalClosure);
  }
}
