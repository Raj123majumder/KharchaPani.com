import 'package:expenses_app/widgets/chart.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import '../widgets/WeeklyPie.dart';

class Stats extends StatelessWidget {
  List<Transactions> _userTransactions;

  Stats(this._userTransactions);

  List<Transactions> get _recentTrans {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      leading: GestureDetector(
        child: Icon(Icons.arrow_back_ios),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: IconThemeData(
        size: 18,
      ),
      title: Text(
        "Statistics",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: (MediaQuery.of(context).size.height -
                      appbar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.5,
              child: Chart(_recentTrans)),
          Container(
            height: (MediaQuery.of(context).size.height -
                    appbar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.5,
            child: WeekPieChart(
              transactions: _recentTrans,
            ),
          ),
        ],
      ),
    );
  }
}
