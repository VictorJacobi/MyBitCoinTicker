import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'Networking.Dart.dart';

String currencyVal ='USD';
dynamic myOnlineData;
var currencyAmountBTC;
var currencyAmountETH;
var currencyAmountLTC;

class PriceScreen extends StatefulWidget {
  final currencyAmountBTC;
  final currencyAmountETH;
  final currencyAmountLTC;
  PriceScreen({this.currencyAmountLTC,this.currencyAmountETH,this.currencyAmountBTC});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  dynamic recreateItem(){
    List <DropdownMenuItem<String>> theItem = [];
    for(int i=0;i<currenciesList.length;i=i+1){
      theItem.add(DropdownMenuItem(child: Text(currenciesList[i]
      ),
          value: currenciesList[i]),);
    }
    return theItem;
  }
  Future<dynamic> getData() async{
    Networking myNetwork = Networking(token: currencyVal);
    myOnlineData = await myNetwork.getNetworkData();
    print(myNetwork.myUrl);
    return(myOnlineData);
  }
  void updateUI(){

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   currencyAmountLTC = widget.currencyAmountLTC;
   currencyAmountETH = widget.currencyAmountETH;
   currencyAmountBTC = widget.currencyAmountBTC;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                    '1 BTC =  ${currencyAmountBTC.toInt()} $currencyVal',//  myOnlineData==null?'1 BTC =  ? USD':
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0,18, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                     '1 ETH =  ${currencyAmountETH.toInt()} $currencyVal',// myOnlineData==null?'1 ETH = ? USD':
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                     '1 LTC =  ${currencyAmountLTC.toInt()} $currencyVal',// myOnlineData==null?'1 LTC = ? USD':
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton(//IOS has a different style. You will learn that later
              value: currencyVal,
              onChanged: (value) async{
                myOnlineData = await getData();
                print(myOnlineData);
                print(currencyVal);
                setState(() {
                  currencyVal=  value;
                  currencyAmountBTC = jsonDecode(myOnlineData)['data']['BTC']['quote']['$currencyVal']['price'];
                  currencyAmountETH = jsonDecode(myOnlineData)['data']['ETH']['quote']['$currencyVal']['price'];
                  currencyAmountLTC =jsonDecode(myOnlineData)['data']['LTC']['quote']['$currencyVal']['price'];
                });
                print(' 1 BTC = $currencyAmountBTC $currencyVal, 1 ETH = $currencyAmountETH $currencyVal, 1 LTC = $currencyAmountLTC $currencyVal ');
              },
              items: recreateItem(),
            ),
          ),
        ],
      ),
    );
  }
}