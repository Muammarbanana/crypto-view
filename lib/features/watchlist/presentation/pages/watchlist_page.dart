import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
          title: const Text('Crypto View'),
        ),
        body: BlocConsumer<CryptoWatchlistBloc, CryptoWatchlistState>(
          listener: (context, state) {
            if (state is CryptoWatchlistError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
            if (state is CryptoWatchlistConnected) {
              _cryptoWatchlistBloc.add(
                CryptoWatchlistSendMessageTriggered(
                  const WebSocketMessageParams(
                    action: 'subscribe',
                    symbols: ['ETH-USD'],
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CryptoWatchlistConnecting) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CryptoWatchlistMessageReceived) {
              final dailyPercentage =
                  double.tryParse(state.message.dc.toString()) ?? 0;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BTC-USD',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      NumberFormat.currency(symbol: r'$').format(
                        double.tryParse(state.message.p.toString()) ?? 0,
                      ),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: dailyPercentage >= 0
                            ? Theme.of(context).color.green
                            : Theme.of(context).color.pink,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            dailyPercentage >= 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: dailyPercentage >= 0
                                ? Theme.of(context).color.darkGreen
                                : Theme.of(context).color.red,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${dailyPercentage.toStringAsFixed(2)}%',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: dailyPercentage >= 0
                                          ? Theme.of(context).color.darkGreen
                                          : Theme.of(context).color.red,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: CryptoChartWidget(
                        cryptoWatchlistBloc: _cryptoWatchlistBloc,
                      ),
                    ),
                    const SizedBox(height: 24),
                    WatchlistTableWidget(),
                  ],
                ),
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
