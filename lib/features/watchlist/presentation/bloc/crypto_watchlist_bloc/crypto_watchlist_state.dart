part of 'crypto_watchlist_bloc.dart';

abstract class CryptoWatchlistState {}

class CryptoWatchlistInitial extends CryptoWatchlistState {}

class CryptoWatchlistConnecting extends CryptoWatchlistState {}

class CryptoWatchlistConnected extends CryptoWatchlistState {}

class CryptoWatchlistMessageReceived extends CryptoWatchlistState {
  CryptoWatchlistMessageReceived(this.message);
  final String message;
}

class CryptoWatchlistDisconnected extends CryptoWatchlistState {}

class CryptoWatchlistError extends CryptoWatchlistState {
  CryptoWatchlistError(this.error);
  final String error;
}
