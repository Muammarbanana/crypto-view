import 'dart:async';
import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_watchlist_event.dart';
part 'crypto_watchlist_state.dart';

class CryptoWatchlistBloc
    extends Bloc<CryptoWatchlistEvent, CryptoWatchlistState> {
  CryptoWatchlistBloc({required this.repository})
      : super(CryptoWatchlistInitial()) {
    on<CryptoWatchlistConnectTriggered>(_onConnectTriggered);
    on<CryptoWatchlistSendMessageTriggered>(_onSendMessageTriggered);
    on<CryptoWatchlistDisconnectTriggered>(_onDisconnectTriggered);
    on<CryptoWatchlistReceiveMessageTriggered>(_onReceiveMessageTriggered);
  }
  final CryptoWatchlistRepository repository;
  StreamSubscription<CryptoWebsocketResponse>? _messagesSubscription;

  Future<void> _onConnectTriggered(
    CryptoWatchlistConnectTriggered event,
    Emitter<CryptoWatchlistState> emit,
  ) async {
    emit(CryptoWatchlistConnecting());
    try {
      await repository.connectToWebSocket();
      emit(CryptoWatchlistConnected());

      _messagesSubscription = repository.messagesStream.listen((message) {
        add(CryptoWatchlistReceiveMessageTriggered(message));
      });
    } catch (e) {
      emit(CryptoWatchlistError(e.toString()));
    }
  }

  void _onSendMessageTriggered(
    CryptoWatchlistSendMessageTriggered event,
    Emitter<CryptoWatchlistState> emit,
  ) {
    emit(CryptoWatchlistConnecting());
    repository.sendMessageToWebSocket(event.message);
  }

  Future<void> _onDisconnectTriggered(
    CryptoWatchlistDisconnectTriggered event,
    Emitter<CryptoWatchlistState> emit,
  ) async {
    await repository.disconnectFromWebSocket();
    await _messagesSubscription?.cancel();
    emit(CryptoWatchlistDisconnected());
  }

  void _onReceiveMessageTriggered(
    CryptoWatchlistReceiveMessageTriggered event,
    Emitter<CryptoWatchlistState> emit,
  ) {
    emit(CryptoWatchlistMessageReceived(event.message));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    repository.disconnectFromWebSocket();
    return super.close();
  }
}
