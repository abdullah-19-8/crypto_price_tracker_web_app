class Crypto {
  String? channel;
  String? timestamp;
  List<Data>? data;
  String? type;

  Crypto({this.channel, this.timestamp, this.data, this.type});

  Crypto.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    timestamp = json['timestamp'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    type = json['type'];
  }
}

class Data {
  double? close;
  double? high;
  double? low;
  double? open;
  String? symbol;
  String? intervalBegin;
  int? trades;
  double? volume;
  double? vwap;
  int? interval;
  String? timestamp;

  Data(
      {this.close,
      this.high,
      this.low,
      this.open,
      this.symbol,
      this.intervalBegin,
      this.trades,
      this.volume,
      this.vwap,
      this.interval,
      this.timestamp});

  Data.fromJson(Map<String, dynamic> json) {
    close = json['close'];
    high = json['high'];
    low = json['low'];
    open = json['open'];
    symbol = json['symbol'];
    intervalBegin = json['interval_begin'];
    trades = json['trades'];
    volume = json['volume'];
    vwap = json['vwap'];
    interval = json['interval'];
    timestamp = json['timestamp'];
  }
}
