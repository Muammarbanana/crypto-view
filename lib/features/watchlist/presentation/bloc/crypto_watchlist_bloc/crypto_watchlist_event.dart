part of 'crypto_watchlist_bloc.dart';

abstract class CryptoWatchlistEvent {}

class CryptoWatchlistConnectTriggered extends CryptoWatchlistEvent {}

class CryptoWatchlistSendMessageTriggered extends CryptoWatchlistEvent {
  CryptoWatchlistSendMessageTriggered(this.message);
  final WebSocketMessageParams message;
}

class CryptoWatchlistDisconnectTriggered extends CryptoWatchlistEvent {}

class CryptoWatchlistReceiveMessageTriggered extends CryptoWatchlistEvent {
  CryptoWatchlistReceiveMessageTriggered(this.message);
  final CryptoWebsocketResponse message;
}
