import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_bloc.dart';
import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_event.dart';
import 'package:crypto_price_tracker_web_app/bloc/crypto_bloc/crypto_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../veiw-model/crypto_view_model.dart';

class CryptoView extends StatefulWidget {
  final String coin;
  const CryptoView({super.key, required this.coin});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  late CryptoBloc _cryptoBloc;

  @override
  void initState() {
    _cryptoBloc = CryptoViewModel().cryptoBloc;
    _cryptoBloc.add(ConnectToWebSocket(widget.coin.toUpperCase()));
    super.initState();
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
              final crypto = state.cryptoData?.data?[0];
              if (crypto?.last != 'null' && crypto?.last != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Symbol: ${crypto?.symbol}'),
                    Text('current Price: ${crypto?.last}'),
                    Text('Highest Price: ${crypto?.high}'),
                    Text('Lowest Price: ${crypto?.low}'),
                    Text('Volume: ${crypto?.volume}'),
                    Text('change percentage: \%${crypto?.changePct}'),
                    Text('VWAP: ${crypto?.vwap}'),
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
