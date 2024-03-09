import '../../models/crypto_model.dart';

class CryptoState {
  final Crypto? cryptoData;
  final double? currentPrice;

  CryptoState(this.cryptoData, this.currentPrice);
}