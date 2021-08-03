import 'package:photo_view/photo_view.dart';
import 'package:clipboard/clipboard.dart';
import 'package:ebced/data/db_helper.dart';
import 'package:ebced/models/ebced.dart';
import 'package:flutter/material.dart';

import 'ebced_letters.dart';

class EbcedCalculate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var backgroundColor = Colors.green;
  var textColor = Colors.white;
  var dbHelper = DbHelper();
  bool isCalculated = false;
  var txtName = TextEditingController();
  var txtHead = TextEditingController();
  var isTick = List<bool>.filled(100, true);
  List<int> total = [];
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ebced Hesapla"),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          buildEbcedLetter(),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: <Widget>[
              buildHeadWidget(),
              buildNameWidget(),
              buildCalculateButton(),
              if (isCalculated)
                buildTitleWidget(),
              if (txtName.text != "" || txtName.text != " ")
                buildListTile(),
              if (isCalculated)
                buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  saveEbced() async {
    if (txtName.text != "") {
      var result = await dbHelper.insert(Ebced(
        name: txtName.text,
        head: txtHead.text,
        calculatedTime: DateTime.now().toString(),
      ));
    }
    Navigator.pop(context, true);
  }

  int valueOfLetter(int index) {
    int deger;
    if (txtName.text[index] == 'ا' ||
        txtName.text[index] == 'ء' ||
        txtName.text[index] == 'أ' ||
        txtName.text[index] == 'آ' ||
        txtName.text[index] == 'ؤ' ||
        txtName.text[index] == 'إ' ||
        txtName.text[index] == 'ئ') //+1
        {
      return deger = 1;
    } else if (txtName.text[index] == 'ب') //be
        {
      return deger = 2;
    } else if (txtName.text[index] == 'ج') //cim
        {
      return deger = 3;
    } else if (txtName.text[index] == 'د') //del
        {
      return deger = 4;
    } else if (txtName.text[index] == 'ه') //he
        {
      return deger = 5;
    } else if (txtName.text[index] == 'و') //vav
        {
      return deger = 6;
    } else if (txtName.text[index] == 'ز') //zı
        {
      return deger = 7;
    } else if (txtName.text[index] == 'ح') //he
        {
      return deger = 8;
    } else if (txtName.text[index] == 'ط') //ta
        {
      return deger = 9;
    } else if (txtName.text[index] == 'ى' ||
        txtName.text[index] == 'ؽ' ||
        txtName.text[index] == 'ؾ' ||
        txtName.text[index] == 'ؿ' ||
        txtName.text[index] == 'ي') //ye
        {
      return deger = 10;
    } else if (txtName.text[index] == 'ك' ||
        txtName.text[index] == 'ػ' ||
        txtName.text[index] == 'ؼ') //kef
        {
      return deger = 20;
    } else if (txtName.text[index] == 'ل') //lam
        {
      return deger = 30;
    } else if (txtName.text[index] == 'م') //mim
        {
      return deger = 40;
    } else if (txtName.text[index] == 'ن') //nun
        {
      return deger = 50;
    } else if (txtName.text[index] == 'س') //sin
        {
      return deger = 60;
    } else if (txtName.text[index] == 'ع') //ayn
        {
      return deger = 70;
    } else if (txtName.text[index] == 'ف') //fe
        {
      return deger = 80;
    } else if (txtName.text[index] == 'ص') //sad
        {
      return deger = 90;
    } else if (txtName.text[index] == 'ق') //kaf
        {
      return deger = 100;
    } else if (txtName.text[index] == 'ر') //re
        {
      return deger = 200;
    } else if (txtName.text[index] == 'ش') //şin
        {
      return deger = 300;
    } else if (txtName.text[index] == 'ت') //te
        {
      return deger = 400;
    } else if (txtName.text[index] == 'ث') //se
        {
      return deger = 500;
    } else if (txtName.text[index] == 'خ') //ğa
        {
      return deger = 600;
    } else if (txtName.text[index] == 'ذ') //zel
        {
      return deger = 700;
    } else if (txtName.text[index] == 'ض') //dad
        {
      return deger = 800;
    } else if (txtName.text[index] == 'ظ') //zı
        {
      return deger = 900;
    } else if (txtName.text[index] == 'غ') //ğayn
        {
      return deger = 1000;
    } else if (txtName.text[index] == 'ة') //te
        {
      return deger = 400;
    } else if (txtName.text[index] == 'ٌ' ||
        txtName.text[index] == 'ً' ||
        txtName.text[index] == 'ٍ') //tenvin nun sayılsa nun
        {
      return deger = 50;
    } else if (txtName.text[index] == 'ّ') //tenvin nun sayılsa nun
        {
      return deger = 9999;
    } else {
      return 0;
    }
  }

  buildHeadWidget() {
    return TextField(
      decoration: InputDecoration(
          labelText: "Tanımlayıcı Başlık", labelStyle: TextStyle(fontSize: 18)),
      controller: txtHead,
      style: TextStyle(fontSize: 25),
    );
  }

  buildTitleWidget(){
    return Container(
      padding: const EdgeInsets.all(2),
      child: ListTile(
        leading: Text('Sırası'),
        title: Text('Harf'),
        trailing: Text('Ebced Değeri'),
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.black26))),
    );
  }

  buildNameWidget() {
    return Row(
      children: [
        Flexible(
          child: TextField(
            decoration: InputDecoration(
                labelText: "Arabi İfade", labelStyle: TextStyle(fontSize: 18)),
            controller: txtName,
            style: TextStyle(fontSize: 25),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.paste),
          onPressed: () {
            FlutterClipboard.paste().then((value) {
              setState(() {
                txtName.text = value;
              });
            });
          },
        )
      ],
    );
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

  void goToLetter() async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=>EbcedLetter()));
  }

  calculateEbced() {
    setState(() {
      result = 0;
      isTick = List<bool>.filled(100, false);
      total.clear();
      isCalculated = true;
    });
  }

  buildCalculateButton() {
    return FlatButton(
        color: backgroundColor,
        onPressed: () {
          if(txtName.text != "")
            calculateEbced();
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(isCalculated)
              Icon(Icons.refresh),
            if(!isCalculated)
              Icon(Icons.calculate_outlined),
          ],
        )
    );
  }

  buildListTile(){
    return Container(
      height: 250,
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(1),
          itemCount: txtName.text.length,
          itemBuilder: (BuildContext context, int index) {
            if ((index == txtName.text.length-2 || index == txtName.text.length-3) && txtName.text[index]== 'ة')                  /// sondaki te ve/veya  he
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((index).toString(),style: TextStyle(fontSize: 25),),
                          Text(txtName.text[index].toString(),style: TextStyle(fontSize: 25),),
                          Text(valueOfLetter(index).toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],),
                      value: isTick[index] != false,
                      onChanged: (bool? value) {
                        setState(() {
                          if(!isTick[index]){
                            ebcedAdd(valueOfLetter(index));
                          }
                          else{
                            ebcedDelete(valueOfLetter(index));
                          }
                          isTick[index]=!isTick[index];
                          cagir();
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Colors.black26))
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(index.toString(),style: TextStyle(fontSize: 25),),
                          Text('ه',style: TextStyle(fontSize: 25),),
                          Text(5.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ],),
                      value: isTick[index+1] != false,
                      onChanged: (bool? value) {
                        setState(() {
                          if(!isTick[index+1]){
                            ebcedAdd(5);
                          }
                          else{
                            ebcedDelete(5);
                          }
                          isTick[index+1]=!isTick[index+1];
                          cagir();
                        });
                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Colors.black26))
                    ),
                  ),
                ],
              );
            else if ( valueOfLetter(index) == 9999 )                                                                              /// şedde ise
              return Container(
                padding: const EdgeInsets.all(2),
                child: CheckboxListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((index-1).toString()+" bbbb ",style: TextStyle(fontSize: 25),),
                      Text(txtName.text[index-1].toString(),style: TextStyle(fontSize: 25),),
                      Text(valueOfLetter(index-1).toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ],),
                  value: isTick[index] != false,
                  onChanged: (bool? value) {
                    setState(() {
                      if(!isTick[index]){
                        ebcedAdd(valueOfLetter(index-1));
                      }
                      else{
                        ebcedDelete(valueOfLetter(index-1));
                      }
                      isTick[index]=!isTick[index];
                      cagir();
                    });
                  },
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Colors.black26))
                ),
              );
            else if (
            valueOfLetter(index)==10 && index>0 && (txtName.text[index-1]== 'ِ' || txtName.text[index-1]== 'ٖ')                   /// ye şeklinde elif ise
            //valueOfLetter(index)==10 && index>0 && (txtName.text[index-1]== 'ِ' || txtName.text[index-1]== '')                   /// vav şeklinde elif ise
            )
              return Container(
                padding: const EdgeInsets.all(2),
                child: CheckboxListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((index).toString(),style: TextStyle(fontSize: 25),),
                      Text(txtName.text[index].toString(),style: TextStyle(fontSize: 25),),
                      Text(1.toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ],),
                  value: isTick[index] != false,
                  onChanged: (bool? value) {
                    setState(() {
                      if(!isTick[index]){
                        ebcedAdd(1);
                      }
                      else{
                        ebcedDelete(1);
                      }
                      isTick[index]=!isTick[index];
                      cagir();
                    });
                  },
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Colors.black26))
                ),
              );
            else if (valueOfLetter(index)!=0)                                                                          /// normal harf
              return Container(
                padding: const EdgeInsets.all(2),
                child: CheckboxListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((index).toString()+" aaaa ",style: TextStyle(fontSize: 25),),
                      Text(txtName.text[index].toString(),style: TextStyle(fontSize: 25),),
                      Text(valueOfLetter(index).toString(),
                        style: TextStyle(fontSize: 25),
                      ),
                    ],),
                  value: isTick[index] != false,
                  onChanged: (bool? value) {
                    setState(() {
                      if(!isTick[index]){
                        ebcedAdd(valueOfLetter(index));
                      }
                      else{
                        ebcedDelete(valueOfLetter(index));
                      }
                      isTick[index]=!isTick[index];
                      cagir();
                    });
                  },
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: Colors.black26))
                ),
              );
            else
              return Container();
          }
      ),
    );
  }

  ebcedAdd(int a){
    setState(() {
      total.add(a);
    });
  }

  ebcedDelete(int a){
    setState(() {
      var b = total.indexOf(a);
      total[b] = 0;
    });
  }

  buildSaveButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
            color: backgroundColor,
            onPressed: () {
              saveEbced();
            },
            child: Text("Kaydet")),
        Text(result.toString(),style: TextStyle(fontSize: 35),),
      ],
    );
  }

  cagir(){
    setState(() {
      result=0;
      for(int i = 0 ; i < total.length ; i++){
        result += total[i];
      }
    });
  }
}
