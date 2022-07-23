import 'package:expenses_app/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/Welcome_bar.dart';

class MyModel with ChangeNotifier {
  DateTime DateSelect = DateTime.now();
  double total = 0.0;
  List<Transactions> userTansactions;
  List<Transactions> recentTansactions = [];

  MyModel(this.userTansactions);

  Future<Null> selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );

    if (pickedDate != null) {
      DateSelect = pickedDate;
      getRecenttransactions();
      print(recentTansactions);
    }

    notifyListeners();
  }

  void getRecenttransactions() {
    print(recentTansactions);
    recentTansactions = userTansactions
        .where((tx) => (tx.date.day == DateSelect.day &&
            tx.date.month == DateSelect.month &&
            tx.date.year == DateSelect.year))
        .toList();

    for (Transactions tx in recentTansactions) {
      total += tx.amount;
    }

    print(recentTansactions);
  }

  void addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: choosenDate,
    );

    userTansactions.add(newTx);

    notifyListeners();
    //_DatewiseTransactions.add(newTx);
    //total += newTx.amount;
  }
}
