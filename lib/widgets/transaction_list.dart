import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> userTransactions;
  final Function deleteTransaction;

  //
  // List<Transactions> TransactionstoShow(List<Transactions> AllTransactions) {
  //   List<Transactions> newList = [];

  //   for (int i = 0; i < AllTransactions.length; i += 1) {
  //     if (AllTransactions[i].date == dateNow) {
  //       newList.add(AllTransactions[i]);
  //     }
  //   }
  //   return newList;
  // }
  TransactionList(
    this.userTransactions,
    this.deleteTransaction,
  );

  @override
  Widget build(BuildContext context) {
    //List<Transactions> ListtoShow = TransactionstoShow(userTransactions);
    //print(userTransactions);
    return userTransactions.isEmpty == true
        ? Column(
            children: [
              Text(
                'No Transactions to show!!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                ),
              ),
            ],
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                  elevation: 7,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xff0095FF)),
                        child: FittedBox(
                          child: Text(
                            '\u{20B9}${userTransactions[index].amount.toStringAsFixed(1)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            userTransactions[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text(
                            DateFormat.yMMMd()
                                .format(userTransactions[index].date),
                            style: TextStyle(color: Colors.grey[500]),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            deleteTransaction(userTransactions[index].id),
                      )
                    ],
                  ));
            },
            itemCount: userTransactions.length,
          );
  }
}
