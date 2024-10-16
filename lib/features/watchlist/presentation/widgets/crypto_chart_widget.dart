import 'package:crypto_view/core/core.dart';
import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartWidget extends StatefulWidget {
  const CryptoChartWidget({
    super.key,
  });

  @override
  State<CryptoChartWidget> createState() => _CryptoChartWidgetState();
}

class _CryptoChartWidgetState extends State<CryptoChartWidget> {
  final CryptoWatchlistBloc _cryptoWatchlistBloc = di<CryptoWatchlistBloc>();
  final CryptoChartCubit _cryptoChartCubit = di<CryptoChartCubit>();
  double dc = 0;
  double p = 0;
  List<ChartData> chartData = [];
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<CryptoChartCubit, String>(
            listener: (context, state) {
              // Resetting the chart data
              setState(
                () {
                  chartData = [];
                },
              );
            },
          ),
          BlocListener<CryptoWatchlistBloc, CryptoWatchlistState>(
            listener: (context, state) {
              if (state is CryptoWatchlistMessageReceived &&
                  state.message.t != null &&
                  state.message.s == _cryptoChartCubit.state) {
                chartData.add(
                  ChartData(
                    DateTime.fromMillisecondsSinceEpoch(state.message.t!),
                    double.tryParse(state.message.p.toString()) ?? 0.0,
                  ),
                );
              }
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
                      symbols: ['BTC-USD', 'ETH-USD'],
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<CryptoWatchlistBloc, CryptoWatchlistState>(
          builder: (context, state) {
            if (state is CryptoWatchlistMessageReceived &&
                chartData.isNotEmpty) {
              // Filter Asset that match with current symbol selection from cryptoChartCubit
              if (state.message.s == _cryptoChartCubit.state) {
                dc = double.tryParse(state.message.dc.toString()) ?? 0.0;
                p = double.tryParse(state.message.p.toString()) ?? 0.0;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    NumberFormat.currency(symbol: r'$').format(
                      double.tryParse(p.toString()) ?? 0,
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: dc >= 0
                          ? Theme.of(context).color.green
                          : Theme.of(context).color.pink,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          dc >= 0 ? Icons.arrow_upward : Icons.arrow_downward,
                          color: dc >= 0
                              ? Theme.of(context).color.darkGreen
                              : Theme.of(context).color.red,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${dc.toStringAsFixed(2)}%',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: dc >= 0
                                        ? Theme.of(context).color.darkGreen
                                        : Theme.of(context).color.red,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Main Chart Asset Widget
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enablePanning: true,
                        zoomMode: ZoomMode.x,
                      ),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        shouldAlwaysShow: true,
                        hideDelay: 5000,
                      ),
                      primaryXAxis: DateTimeAxis(
                        initialVisibleMinimum: chartData.first.x
                            .subtract(const Duration(minutes: 5)),
                        initialVisibleMaximum:
                            chartData.last.x.add(const Duration(minutes: 5)),
                        minimum: chartData.first.x
                            .subtract(const Duration(minutes: 5)),
                        maximum:
                            chartData.last.x.add(const Duration(minutes: 5)),
                        intervalType: DateTimeIntervalType.minutes,
                      ),
                      primaryYAxis: NumericAxis(
                        numberFormat: NumberFormat.decimalPatternDigits(),
                      ),
                      series: <CartesianSeries<dynamic, dynamic>>[
                        // Renders spline chart
                        SplineAreaSeries<ChartData, DateTime>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          borderColor: (((double.tryParse(
                                        state.message.dc.toString(),
                                      )) ??
                                      0.0) <
                                  0)
                              ? Theme.of(context).color.red
                              : Theme.of(context).color.blue,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              if (((double.tryParse(
                                        state.message.dc.toString(),
                                      )) ??
                                      0.0) <
                                  0)
                                Theme.of(context).color.pink
                              else
                                Theme.of(context).color.lightBlue,
                              Colors.white,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CryptoWatchlistConnecting) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CryptoWatchlistError) {
              return Center(
                child: Text('Error: ${state.error}'),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
