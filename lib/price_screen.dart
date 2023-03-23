import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coinfetch.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  var priceBTC;
  var priceETH;
  var priceADA;
  String selectedCurrency;
  CoinFetcher coinfetchBTC = CoinFetcher('BTC');
  CoinFetcher coinfetchETH = CoinFetcher('ETH');
  CoinFetcher coinfetchADA = CoinFetcher('ADA');
  //ANDROID OR IOS
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (int i = 0; i < currenciesList.length; i++){
      print(currenciesList[i]);
      var newItem = DropdownMenuItem(child:
      Text(currenciesList[i]),
        value: currenciesList[i],
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(value);
        });
      },
    );
  }
  CupertinoPicker iOSPicker() {
    List<Text> theEntireList = [];
    for (String currency in currenciesList){
      theEntireList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged:
          (selectedIndex) async{
        selectedCurrency = currenciesList[selectedIndex];
        print(selectedCurrency);
        var cryptoDataBTC = await coinfetchBTC.getConversion(selectedCurrency);
        var cryptoDataETH = await coinfetchETH.getConversion(selectedCurrency);
        var cryptoDataADA = await coinfetchADA.getConversion(selectedCurrency);
        updateUI(cryptoDataBTC, 0);
        updateUI(cryptoDataETH, 1);
        updateUI(cryptoDataADA, 2);//THIS UPDATES UI
      },
      children: theEntireList,
    );
  }
  //ANDROID OR IOS
  //UPDATE UI
  void updateUI(dynamic cryptoData, int curry) {
    setState(() {
      //default value
      if (cryptoData == null) {
        //price = 0;
        return;
      }
      if (curry == 0) {
        priceBTC = cryptoData["rate"].toInt();
      }
      if (curry == 1) {
        priceETH = cryptoData["rate"].toInt();
      }
      if (curry == 2) {
        priceADA = cryptoData["rate"].toInt();
      }
    });
  }
  //UPDATE UI
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
                  '1 BTC = $priceBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),//BTC
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
                  '1 ETH = $priceETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),//ETC
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
                  '1 ADA = $priceADA $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),//ADA
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: //THE WIDGET FOR SELECTION
                Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}


