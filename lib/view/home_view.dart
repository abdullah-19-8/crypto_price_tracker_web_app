import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_event.dart';
import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../veiw-model/crypto_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CryptoBloc _cryptoBloc;

  @override
  void initState() {
    super.initState();
    _cryptoBloc = CryptoViewModel().cryptoBloc;
    _cryptoBloc.subscribeToMarketDataStreams();
    _cryptoBloc.add(ConnectToWebSocket());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kraken WebSocket'),
        ),
        body: Center(
          child: BlocBuilder<CryptoBloc, CryptoState>(
            bloc: _cryptoBloc,
            builder: (context, state) {
              if (state.cryptoData != null) {
                final crypto = state.cryptoData?.data?[0];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Symbol: ${crypto?.symbol}'),
                    Text('Open Price: ${crypto?.open}'),
                    Text('High Price: ${crypto?.high}'),
                    Text('Low Price: ${crypto?.low}'),
                    Text('Close Price: ${crypto?.close}'),
                    Text('Volume: ${crypto?.volume}'),
                    Text('Trades: ${crypto?.trades}'),
                    Text('VWAP: ${crypto?.vwap}'),
                    Text('Interval: ${crypto?.interval}'),
                    Text('Timestamp: ${crypto?.timestamp}'),
                  ],
                );
              } else {
                return Text('Loading...');
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cryptoBloc.close(); // Close the bloc when the widget is disposed
    super.dispose();
  }
}
