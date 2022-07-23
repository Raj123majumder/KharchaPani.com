import 'package:flutter/material.dart';
import '../models/transactions.dart';
import '../providers/MyModel.dart';

class getPdf extends StatelessWidget {
  List<Transactions> userTransactions;

  getPdf(this.userTransactions);

  @override
  Widget build(BuildContext context) {
    return Text("hi!");
  }
}
