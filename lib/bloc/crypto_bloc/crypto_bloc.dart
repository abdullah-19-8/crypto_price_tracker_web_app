import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/crypto_model.dart';
import 'crypto_event.dart';
import 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  WebSocketChannel? channel;
  Crypto? crypto;

  CryptoBloc() : super(CryptoState(null)) {
    on<ConnectToWebSocket>((event, emit) {
      channel = HtmlWebSocketChannel.connect('wss://ws.kraken.com/v2');
      subscribeToMarketDataStreams(event.coin);
      emit(
        state,
      ); // Emit the current state to indicate the connection is established
      // fixed

      channel?.stream.listen((message) {
        Map<String, dynamic> jsonMap = jsonDecode(message);

        if (jsonMap['data'] != null) {
          crypto = Crypto.fromJson(jsonMap);
        }
        add(FetchCryptoData()); // Trigger data update when WebSocket receives new data
      });
    });

    on<FetchCryptoData>((event, emit) {
      emit(CryptoState(crypto));
    });
  }

  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if (event is ConnectToWebSocket) {
      yield CryptoState(crypto);
    }
  }

  void callSubscribe() {}

  void subscribeToMarketDataStreams(String coin) {
    channel?.sink.add(json.encode({
      "method": "subscribe",
      "params": {
        "channel": "ticker",
        "snapshot": true,
        "symbol": ["$coin/USD"]
      },
      "req_id": 1234567890
    }));
  }

  @override
  Future<void> close() {
    channel?.sink.close();
    return super.close();
  }
}
