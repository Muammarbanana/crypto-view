import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoWatchlistRemoteDatasource {
  WebSocketChannel? _channel;

  Stream<String> get messagesStream =>
      _channel!.stream.map((event) => event.toString());

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
