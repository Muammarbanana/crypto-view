import 'package:crypto_view/core/utils/injection_containers.dart';
import 'package:crypto_view/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});
  static const routeName = '/watchlist-page';

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final CryptoWatchlistBloc _cryptoWatchlistBloc = di<CryptoWatchlistBloc>();

  @override
  void initState() {
    _cryptoWatchlistBloc.add(CryptoWatchlistConnectTriggered());
    super.initState();
  }

  @override
  void dispose() {
    _cryptoWatchlistBloc.add(CryptoWatchlistDisconnectTriggered());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cryptoWatchlistBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket Example'),
        ),
        body: BlocConsumer<CryptoWatchlistBloc, CryptoWatchlistState>(
          listener: (context, state) {
            if (state is CryptoWatchlistMessageReceived) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('New message: ${state.message}')),
              );
            } else if (state is CryptoWatchlistError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is CryptoWatchlistConnecting) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CryptoWatchlistConnected ||
                state is CryptoWatchlistMessageReceived) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Connected to WebSocket'),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CryptoWatchlistBloc>().add(
                            CryptoWatchlistSendMessageTriggered(
                              const WebSocketMessageParams(
                                action: 'subscribe',
                                symbols: ['BTC-USD', 'ETH-USD'],
                              ),
                            ),
                          );
                    },
                    child: const Text('Send Message'),
                  ),
                ],
              );
            } else if (state is CryptoWatchlistDisconnected) {
              return const Center(
                child: Text('Disconnected from WebSocket'),
              );
            } else if (state is CryptoWatchlistError) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
