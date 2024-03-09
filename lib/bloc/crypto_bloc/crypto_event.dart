abstract class CryptoEvent {}

class FetchCryptoData extends CryptoEvent {}

class ConnectToWebSocket extends CryptoEvent {
  final String coin;

   ConnectToWebSocket(this.coin);
}