import 'package:crypto_view/core/core.dart';
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
  final CryptoChartCubit _cryptoChartCubit = di<CryptoChartCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocProvider(
              create: (context) => _cryptoChartCubit,
              child: BlocBuilder<CryptoChartCubit, String>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                        items: [
                          DropdownMenuItem(
                            value: 'BTC-USD',
                            child: Text(
                              'BTC-USD',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'ETH-USD',
                            child: Text(
                              'ETH-USD',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                        value: state,
                        onChanged: (value) {
                          _cryptoChartCubit.selectCryptoAsset(value.toString());
                        },
                      ),
                      const CryptoChartWidget(),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const WatchlistTableWidget(),
          ],
        ),
      ),
    );
  }
}
