import 'package:crypto_view/features/watchlist/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CryptoChartWidget extends StatefulWidget {
  const CryptoChartWidget({
    required this.cryptoWatchlistBloc,
    super.key,
  });
  final CryptoWatchlistBloc cryptoWatchlistBloc;

  @override
  State<CryptoChartWidget> createState() => _CryptoChartWidgetState();
}

class _CryptoChartWidgetState extends State<CryptoChartWidget> {
  List<ChartData> chartData = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CryptoWatchlistBloc, CryptoWatchlistState>(
      listener: (context, state) {
        if (state is CryptoWatchlistMessageReceived) {
          chartData.add(
            ChartData(
              DateTime.fromMillisecondsSinceEpoch(state.message.t!),
              double.tryParse(state.message.p.toString()) ?? 0.0,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CryptoWatchlistMessageReceived && chartData.isNotEmpty) {
          return SfCartesianChart(
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
              initialVisibleMinimum:
                  chartData.first.x.subtract(const Duration(minutes: 5)),
              initialVisibleMaximum:
                  chartData.last.x.add(const Duration(minutes: 5)),
              minimum: chartData.first.x.subtract(const Duration(minutes: 5)),
              maximum: chartData.last.x.add(const Duration(minutes: 5)),
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
                borderColor: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.blue.withOpacity(0.2),
                    Colors.white,
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
