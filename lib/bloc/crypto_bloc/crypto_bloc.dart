import 'dart:convert';

import 'package:crypto_price_tracker_web_app/models/crypto_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  WebSocketChannel? channel;
  Crypto? crypto;
  double? price;

  CryptoBloc() : super(CryptoState(null, null)) {
    on<ConnectToWebSocket>((event, emit) {
      print('object');
      channel = IOWebSocketChannel.connect('wss://ws.kraken.com/v2');
      subscribeToMarketDataStreams();
      emit(
        state,
      ); // Emit the current state to indicate the connection is established
      channel?.stream.listen((message) {
        Map<String, dynamic> jsonMap = jsonDecode(message);

        if (jsonMap['data'] != null) {
          crypto = Crypto.fromJson(jsonMap);
        }
        add(FetchCryptoData()); // Trigger data update when WebSocket receives new data
      });
    });

    on<FetchCryptoData>((event, emit) {
      emit(CryptoState(crypto, price));
    });
  }

  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if (event is FetchCryptoData) {
      // Perform API call or data fetching logic here
      // For simplicity, let's use sample data
      final sampleData = {
        "channel": "ohlc",
        "timestamp": "2022-06-13T08:09:10.123456Z",
        "data": [
          {
            "close": 30001.4,
            "high": 3000.9,
            "low": 3000.1,
            "open": 3000.3,
            "symbol": "BTC/USD",
            "interval_begin": "2022-06-12T08:09:10.123456Z",
            "trades": 1,
            "volume": 0.0001,
            "vwap": 3000.3,
            "interval": 5,
            "timestamp": "2022-06-13T08:09:10.123456Z",
          }
        ],
        "type": "snapshot"
      };

      final Crypto? cryptoData = Crypto.fromJson(sampleData);

      yield CryptoState(cryptoData, price);
    } else if (event is ConnectToWebSocket) {
      // print('object');
      // channel = IOWebSocketChannel.connect('wss://ws.kraken.com/v2');
      // subscribeToMarketDataStreams();
      // yield state; // Yield the current state to indicate the connection is established
      channel?.stream.listen((message) {
        crypto = Crypto.fromJson(message);
        if (crypto?.data != null) {
          price = crypto?.data?[0].open;
        }
        add(FetchCryptoData()); // Trigger data update when WebSocket receives new data
      });
      yield CryptoState(crypto, price);
    }
  }

  void subscribeToMarketDataStreams() {
    channel?.sink.add(json.encode({
      "method": "subscribe",
      "params": {
        "channel": "ohlc",
        "symbol": ["BTC/USD"],
        "interval": 5
      }
    }));
  }

  @override
  Future<void> close() {
    channel?.sink.close();
    return super.close();
  }
}
