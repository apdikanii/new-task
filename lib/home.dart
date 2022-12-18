import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 238, 230),
        title: Text('Welcome Abdikani...', style: TextStyle(
          color: Color.fromARGB(255, 86, 34, 132), fontSize: 23.0, fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          //inside the listview
          children: [
            //first container
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 237, 234, 238),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Per Person..", style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.0,
                    color: Color.fromARGB(255, 8, 144, 255)
                  ),),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}", style: TextStyle(
                      color: Color.fromARGB(255, 8, 144, 255),
                      fontSize: 34.9,
                      fontWeight: FontWeight.bold
                    ),),
                  )
                ],
              ),
            ),
            //second container
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blue.shade400,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                //this is the second container's array
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Color.fromARGB(255, 8, 144, 255)),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount: ",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value) {
                      try{
                        _billAmount = double.parse(value);
                      }catch(exception){
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  //first row inside the second container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(
                        color: Color.fromARGB(255, 8, 144, 255)
                      ),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                             setState(() {
                                if(_personCounter > 1){
                                _personCounter--;
                              }else{
                                //do nothing
                              }
                             });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Color.fromARGB(255, 97, 90, 70).withOpacity(0.1)
                              ),
                              child: Center(
                                child: Text(
                                  "-", style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCounter",
                          style: TextStyle(
                            color: Colors.black26,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0
                          ),),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 115, 105, 105).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0)
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //second row inside the scond container
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Tip", style: TextStyle(
                          color: Color.fromARGB(255, 8, 144, 255),
                        ),),
                      ),
                      Text("\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPercentage).toStringAsFixed(2)}", style: TextStyle(
                        color: Color.fromARGB(255, 8, 144, 255), 
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                      ),)
                    ],
                  ),
                  //now it is a column inside the second conatiner
                  Column(
                    children: [
                      Text("$_tipPercentage% ", style: TextStyle(
                        color: Color.fromARGB(255, 8, 144, 255),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                        min: 0,
                        max: 100,
                        activeColor: Colors.grey,
                        divisions: 10,
                        value: _tipPercentage.toDouble(), 
                        onChanged: (double newValue){
                          setState(() {
                            _tipPercentage = newValue.round();
                          });

                      })
                    ],
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage){
    var totalPepPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPepPerson.toStringAsFixed(2);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              

  }
  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null){
      //no go!
    }else{
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}