class Crypto {
  String? channel;
  List<Data>? data;
  String? type;

  Crypto({this.channel, this.data, this.type});

  Crypto.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
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
  String? ask;
  String? bidQty;
  String? change;
  String? changePct;
  String? high;
  String? last;
  String? low;
  String? symbol;
  String? volume;
  String? vwap;

  Data(
      {this.ask,
      this.bidQty,
      this.change,
      this.changePct,
      this.high,
      this.last,
      this.low,
      this.symbol,
      this.volume,
      this.vwap});

  Data.fromJson(Map<String, dynamic> json) {
    ask = json['ask'].toString();
    bidQty = json['bid_qty'].toString();
    change = json['change'].toString();
    changePct = json['change_pct'].toString();
    high = json['high'].toString();
    last = json['last'].toString();
    low = json['low'].toString();
    symbol = json['symbol'].toString();
    volume = json['volume'].toString();
    vwap = json['vwap'].toString();
  }
}