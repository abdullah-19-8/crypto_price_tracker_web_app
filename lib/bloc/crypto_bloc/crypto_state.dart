import '../../models/crypto_model.dart';

class CryptoState {
  final List<Data>? cryptoData;
  final double? currentPrice;

  CryptoState(this.cryptoData, this.currentPrice);
}