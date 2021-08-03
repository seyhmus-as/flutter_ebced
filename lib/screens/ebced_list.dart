
import 'package:ebced/data/db_helper.dart';
import 'package:ebced/models/ebced.dart';
import 'package:ebced/screens/ebced_calculate.dart';
import 'package:ebced/screens/ebced_letters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ebced_detail.dart';

class EbcedList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EbcedListState();
  }
}

class _EbcedListState extends State {
  var dbHelper = DbHelper();
  List<Ebced> products = [];
  int productCount = 0;
  var backgroundColor = Colors.green;
  var textColor = Colors.white;

  @override
  void initState() {
    getEbceds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Ebced Listesi"),
        actions: <Widget>[
          buildEbcedLetter(),
        ],
      ),
      body: buildEbcedList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: () {
          goToEbcedAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ebced Ekle",
      ),
    );
  }

  ListView? buildEbcedList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, position) {
          return Card(
              color: backgroundColor,
              elevation: 2.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Text("ebc"),
                ),
                title: Text(this.products[position].head!,style: TextStyle(color: textColor,fontSize: 25),),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(this.products[position].name!,style: TextStyle(color: textColor,fontSize: 25),),
                  ],
                ) ,
                onTap: () {goToDetail(this.products[position]);},
              )
          );
        });
  }

  void goToEbcedAdd() async {
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EbcedCalculate()));
    if (result != null) {
      if (result) {
        getEbceds();
      }
    }
  }

  void getEbceds() async {
    var productFuture = dbHelper.getEbceds();
    productFuture.then((value) {
      setState(() {
        this.products = value;
        this.productCount = value.length;
      });
    });
  }

  void goToDetail(Ebced product) async{
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EbcedDetail(product)));
    if(result!=null){
      if(result){
        getEbceds();
      }
    }
  }

  void goToLetter() async{
    bool? result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EbcedLetter()));
    if(result!=null){
      if(result){
        getEbceds();
      }
    }
  }

  buildEbcedLetter(){
    return IconButton(
      icon: Icon(
        Icons.wallpaper_rounded,
        color: Colors.white,
      ),
      onPressed: () {
        print('aaaaaaaaaa');
        goToLetter();
      },
    );
  }
}
