import 'dart:convert';

import 'package:crypto_price_tracker_web_app/models/crypto_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/html.dart';
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
      channel = HtmlWebSocketChannel.connect('wss://ws.kraken.com/v2');
      subscribeToMarketDataStreams(event.coin);
      emit(
        state,
      ); // Emit the current state to indicate the connection is established
      channel?.stream.listen((message) {
        Map<String, dynamic> jsonMap = jsonDecode(message);

        if (jsonMap['data'] != null) {
          print('updated');
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
    if (event is ConnectToWebSocket) {
      yield CryptoState(crypto, price);
    }
  }

  void callSubscribe() {}

  void subscribeToMarketDataStreams(String coin) {
    channel?.sink.add(json.encode({
      "method": "subscribe",
      "params": {
        "channel": "ohlc",
        "symbol": ["$coin/USD"],
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
