import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTableWidget extends StatefulWidget {
  const WatchlistTableWidget({super.key});

  @override
  State<WatchlistTableWidget> createState() => _WatchlistTableWidgetState();
}

class _WatchlistTableWidgetState extends State<WatchlistTableWidget> {
  final CryptoWatchlistBloc _cryptoWatchlistBloc = di<CryptoWatchlistBloc>();
  final List<String> symbolList = ['BTC-USD', 'ETH-USD'];
  CryptoWebsocketResponse? _btcResponse = const CryptoWebsocketResponse();
  CryptoWebsocketResponse? _ethResponse = const CryptoWebsocketResponse();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Watchlist',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        BlocProvider(
          create: (context) => _cryptoWatchlistBloc,
          child: BlocConsumer<CryptoWatchlistBloc, CryptoWatchlistState>(
            listener: (context, state) {
              if (state is CryptoWatchlistError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
              if (state is CryptoWatchlistConnected) {
                _cryptoWatchlistBloc.add(
                  CryptoWatchlistSendMessageTriggered(
                    WebSocketMessageParams(
                      action: 'subscribe',
                      symbols: symbolList,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is CryptoWatchlistConnecting) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CryptoWatchlistMessageReceived) {
                if (state.message.s == symbolList[0]) {
                  _btcResponse = state.message;
                } else {
                  _ethResponse = state.message;
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: DataTable(
                      columnSpacing: 12,
                      columns: const [
                        DataColumn(
                          label: Text('Symbol'),
                        ),
                        DataColumn(
                          label: Text('Last'),
                        ),
                        DataColumn(
                          label: Text('Chg'),
                        ),
                        DataColumn(
                          label: Text('Chg%'),
                        ),
                      ],
                      rows: symbolList.map((symbol) {
                        return DataRow(
                          cells: [
                            DataCell(Text(symbol)),
                            DataCell(
                              Text(
                                symbol == 'BTC-USD'
                                    ? '${double.tryParse('${_btcResponse?.p}')?.toStringAsFixed(2) ?? 0}'
                                    : '${double.tryParse('${_ethResponse?.p}')?.toStringAsFixed(2) ?? 0}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: (double.tryParse(
                                                    '${symbol == 'BTC-USD' ? _btcResponse?.dc : _ethResponse?.dc}',
                                                  ) ??
                                                  0) >
                                              0
                                          ? Theme.of(context).color.darkGreen
                                          : Theme.of(context).color.red,
                                    ),
                              ),
                            ),
                            DataCell(
                              Text(
                                symbol == 'BTC-USD'
                                    ? '${double.tryParse('${_btcResponse?.dd}')?.toStringAsFixed(2) ?? 0}'
                                    : '${double.tryParse('${_ethResponse?.dd}')?.toStringAsFixed(2) ?? 0}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: (double.tryParse(
                                                    '${symbol == 'BTC-USD' ? _btcResponse?.dc : _ethResponse?.dc}',
                                                  ) ??
                                                  0) >
                                              0
                                          ? Theme.of(context).color.darkGreen
                                          : Theme.of(context).color.red,
                                    ),
                              ),
                            ),
                            DataCell(
                              Text(
                                symbol == 'BTC-USD'
                                    ? '${double.tryParse('${_btcResponse?.dc}')?.toStringAsFixed(2) ?? 0}%'
                                    : '${double.tryParse('${_ethResponse?.dc}')?.toStringAsFixed(2) ?? 0}%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: (double.tryParse(
                                                    '${symbol == 'BTC-USD' ? _btcResponse?.dc : _ethResponse?.dc}',
                                                  ) ??
                                                  0) >
                                              0
                                          ? Theme.of(context).color.darkGreen
                                          : Theme.of(context).color.red,
                                    ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
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
      ],
    );
  }
}
