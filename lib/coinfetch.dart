import 'network.dart';

class CoinFetcher {
  CoinFetcher(this.crypto);
  final String crypto;

  String apikey = "AC44F605-F6FB-422B-BD1B-35AA45C1CA8F";
  String url;

  Future<dynamic> getConversion(String curry) async {
    url = "https://rest.coinapi.io/v1/exchangerate/$crypto/$curry?apikey=$apikey";
    NetworkHelper networkHelper = NetworkHelper(url);
    var cryptoData = await networkHelper.getData();
    //print("CALLED CONVERSION");
    //print(cryptoData);
    return(cryptoData);
  }
}