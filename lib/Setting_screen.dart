import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'Networking.Dart.dart';
import 'dart:convert';
import 'price_screen.dart';
dynamic myOnlineData;
double currencyAmount;
var currencyValue;
var currencyAmountBTC;
var currencyAmountETH;
var currencyAmountLTC;
class Starting extends StatefulWidget {
  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  void getData() async{
    Networking myNetwork = Networking(token: 'USD');
    myOnlineData = await myNetwork.getNetworkData();
    currencyAmountBTC = jsonDecode(myOnlineData)['data']['BTC']['quote']['USD']['price'];
    currencyAmountETH = jsonDecode(myOnlineData)['data']['ETH']['quote']['USD']['price'];
    currencyAmountLTC =jsonDecode(myOnlineData)['data']['LTC']['quote']['USD']['price'];
    print(myNetwork.myUrl);
    print(' 1 BTC = $currencyAmountBTC $currencyVal, 1 ETH = $currencyAmountETH $currencyVal, 1 LTC = $currencyAmountLTC $currencyVal ');
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return PriceScreen(currencyAmountBTC: currencyAmountBTC,currencyAmountETH: currencyAmountETH,currencyAmountLTC: currencyAmountLTC);
    }));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
  //  getData('BTC');
    return Container(
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
