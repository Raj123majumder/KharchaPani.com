import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/MyModel.dart';
import '../models/transactions.dart';

class welcomebar extends StatelessWidget{
  final double total;
  List<Transactions> userTansactions;
  UserModel loggedInUser = UserModel();


  welcomebar(this.total, this.userTansactions, this.loggedInUser);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 15.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Consumer<MyModel>(
                        builder: (context, value, child) => Text(
                          value.DateSelect == null
                              ? "No Date"
                              : DateFormat.yMMMd().format(value.DateSelect),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Consumer<MyModel>(
                  builder: (context, value, child) => MaterialButton(
                    height: 40,
                    minWidth: double.infinity,
                    onPressed: () => value.selectDate(context),
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    color: Color(0xff0095FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 3, 109, 185),
                  Color(0xff0095FF),
                  Color.fromARGB(231, 132, 196, 241),
                ])),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi!!",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                        ),
                        Text(
                          "${loggedInUser.firstName} ${loggedInUser.secondName}",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Image.asset("assets/icons8-money-100.png")
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Total Expenses",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Expanded(child: Container()),
                    Consumer<MyModel>(
                      builder: (context, value, child) => Text(
                        '\u{20B9}${value.total.toStringAsFixed(1)}',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ), 
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
