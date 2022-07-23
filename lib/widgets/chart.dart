import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTranscations;

  Chart(this.recentTranscations);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalExpense = 0.0;

      for (var i = 0; i < recentTranscations.length; i += 1) {
        if (recentTranscations[i].date.day == weekDay.day &&
            recentTranscations[i].date.month == weekDay.month &&
            recentTranscations[i].date.year == weekDay.year) {
          totalExpense += recentTranscations[i].amount;
        }
      }
      //print(DateFormat.E().format(weekDay));
      //print(totalExpense);

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalExpense
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Bar Chart",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(child: Container()),
                  Image.asset(
                    'assets/icons8-bar-chart-24.png',
                  )
                ],
              )),
          Padding(
            child: Divider(
              color: Colors.black,
              thickness: 0.4,
            ),
            padding: EdgeInsets.all(10),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((TransacDetails) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    TransacDetails['day'] as String,
                    TransacDetails['amount'] as double,
                    maxSpending == 0.0
                        ? 0.0
                        : (TransacDetails['amount'] as double) / maxSpending,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
