import '../bloc/crypto_bloc/crypto_bloc.dart';
import '../bloc/crypto_bloc/crypto_event.dart';
import '../bloc/crypto_bloc/crypto_state.dart';

class CryptoViewModel {
  final CryptoBloc _cryptoBloc = CryptoBloc();

  Stream<CryptoState> get cryptoStream => _cryptoBloc.stream;

  void fetchCryptoData() {
    _cryptoBloc.add(FetchCryptoData());
  }

  void dispose() {
    _cryptoBloc.close();
  }

  CryptoBloc get cryptoBloc => _cryptoBloc;
}
