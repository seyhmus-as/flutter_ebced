import 'package:ebced/data/db_helper.dart';
import 'package:ebced/models/ebced.dart';
import 'package:ebced/screens/ebced_letters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';

class EbcedDetail extends StatefulWidget {
  Ebced ebced;
  EbcedDetail(this.ebced);

  @override
  State<StatefulWidget> createState() {
    return _EbcedDetailState(ebced);
  }
}

enum Options { delete, update }

class _EbcedDetailState extends State {
  var isTick = List<bool>.filled(100, false);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtHead = TextEditingController();
  var txtCalculatedTime= TextEditingController();
  var backgroundColor = Colors.green;
  var textColor = Colors.white;
  _EbcedDetailState(this.ebced);
  bool isCalculated = true;
  List<int> total = [];
  int result = 0;
  Ebced? ebced;

  @override
  void initState() {
    txtName.text = ebced!.name!;
    txtHead.text = ebced!.head!;
    txtCalculatedTime.text = ebced!.calculatedTime!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Ebced Hesapla"),
        backgroundColor: backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.wallpaper_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              goToLetter();
            },
          ),
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
                buildResultWidget(),
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
    if (txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??') //+1
        {
      return deger = 1;
    } else if (txtName.text[index] == '??') //be
        {
      return deger = 2;
    } else if (txtName.text[index] == '??') //cim
        {
      return deger = 3;
    } else if (txtName.text[index] == '??') //del
        {
      return deger = 4;
    } else if (txtName.text[index] == '??') //he
        {
      return deger = 5;
    } else if (txtName.text[index] == '??') //vav
        {
      return deger = 6;
    } else if (txtName.text[index] == '??') //z??
        {
      return deger = 7;
    } else if (txtName.text[index] == '??') //he
        {
      return deger = 8;
    } else if (txtName.text[index] == '??') //ta
        {
      return deger = 9;
    } else if (txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??') //ye
        {
      return deger = 10;
    } else if (txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??') //kef
        {
      return deger = 20;
    } else if (txtName.text[index] == '??') //lam
        {
      return deger = 30;
    } else if (txtName.text[index] == '??') //mim
        {
      return deger = 40;
    } else if (txtName.text[index] == '??') //nun
        {
      return deger = 50;
    } else if (txtName.text[index] == '??') //sin
        {
      return deger = 60;
    } else if (txtName.text[index] == '??') //ayn
        {
      return deger = 70;
    } else if (txtName.text[index] == '??') //fe
        {
      return deger = 80;
    } else if (txtName.text[index] == '??') //sad
        {
      return deger = 90;
    } else if (txtName.text[index] == '??') //kaf
        {
      return deger = 100;
    } else if (txtName.text[index] == '??') //re
        {
      return deger = 200;
    } else if (txtName.text[index] == '??') //??in
        {
      return deger = 300;
    } else if (txtName.text[index] == '??') //te
        {
      return deger = 400;
    } else if (txtName.text[index] == '??') //se
        {
      return deger = 500;
    } else if (txtName.text[index] == '??') //??a
        {
      return deger = 600;
    } else if (txtName.text[index] == '??') //zel
        {
      return deger = 700;
    } else if (txtName.text[index] == '??') //dad
        {
      return deger = 800;
    } else if (txtName.text[index] == '??') //z??
        {
      return deger = 900;
    } else if (txtName.text[index] == '??') //??ayn
        {
      return deger = 1000;
    } else if (txtName.text[index] == '??') //te
        {
      return deger = 400;
    } else if (txtName.text[index] == '??' ||
        txtName.text[index] == '??' ||
        txtName.text[index] == '??') //tenvin nun say??lsa nun
        {
      return deger = 50;
    } else if (txtName.text[index] == '??') //tenvin nun say??lsa nun
        {
      return deger = 9999;
    } else {
      return 0;
    }
  }

  buildHeadWidget() {
    return TextField(
      decoration: InputDecoration(
          labelText: "Tan??mlay??c?? Ba??l??k", labelStyle: TextStyle(fontSize: 18)),
      controller: txtHead,
      style: TextStyle(fontSize: 25),
    );
  }

  buildTitleWidget(){
    return Container(
      padding: const EdgeInsets.all(2),
      child: ListTile(
        leading: Text('S??ras??'),
        title: Text('Harf'),
        trailing: Text('Ebced De??eri'),
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
                labelText: "Arabi ??fade", labelStyle: TextStyle(fontSize: 18)),
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
            if ((index == txtName.text.length-2 || index == txtName.text.length-3) && txtName.text[index]== '??')  /// sondaki te ve/veya  he
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    child: CheckboxListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text((index).toString()+" cccc  ",style: TextStyle(fontSize: 25),),
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
                          Text(index.toString()+" dddd ",style: TextStyle(fontSize: 25),),
                          Text('??',style: TextStyle(fontSize: 25),),
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
            if ( valueOfLetter(index) == 9999 )                                                                   /// ??edde ise
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
            if (valueOfLetter(index)!=0)                                                                          /// normal harf
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

  buildResultWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
