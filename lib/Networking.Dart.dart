import 'package:http/http.dart' as http;

class Networking{
  Uri myUrl;
  String token;
  Networking({this.token});
 Future<dynamic> getNetworkData() async{
    myUrl = Uri.parse('https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC,ETH,LTC&convert=$token');//anything after the question mark represents data or parameters
    dynamic onlineData = await http.get(myUrl,
    headers: {
      'X-CMC_PRO_API_KEY':'8b8238b5-2998-4d01-b31f-491d94c29221',
      'Accept':'application/json',
    });
    if(onlineData.statusCode==200){
      print(onlineData.statusCode);
      return(onlineData.body);
    }else{
      return(onlineData.statusCode);
    }
  }
}