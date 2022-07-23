import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_app/models/user_model.dart';
import 'package:expenses_app/providers/MyModel.dart';
import 'package:expenses_app/screens/login_screen.dart';
import 'package:expenses_app/widgets/Welcome_bar.dart';
import 'package:expenses_app/widgets/logoutPdfScreen.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transactions.dart';
import '../widgets/getPdf.dart';
import 'package:intl/intl.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../screens/Stats.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double total = 0.0;

  final List<Transactions> _userTransactions = [];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users_info")
        .doc(user!.uid)
        .get()
        .then(((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    }));
  }

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transactions(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: choosenDate,
    );

    setState(() {
      _userTransactions.add(newTx);
      //_DatewiseTransactions.add(newTx);
      total += newTx.amount;
    });
  }

  void _deleteTransaction(String id) {
    double totaldelete = 0.0;
    for (int i = 0; i < _userTransactions.length; i++) {
      if (_userTransactions[i].id == id) {
        totaldelete += _userTransactions[i].amount;
      }
    }
    setState(() {
      total -= totaldelete;
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _moreVert(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: logoutPdfScreen(),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text(
        'KharchaPani',
        style: TextStyle(fontWeight: FontWeight.bold),
        //TextStyle(fontWeight: FontWeight.bold)
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add)),
        //IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => Stats(_userTransactions))),
            icon: Icon(Icons.bar_chart)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.picture_as_pdf)),
        IconButton(
            onPressed: () => logout(context), icon: Icon(Icons.logout_rounded)),
      ],
      iconTheme: IconThemeData(
        size: 18,
      ),
    );
    return ChangeNotifierProvider<MyModel>(
      create: (context) => MyModel(_userTransactions),
      child: Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appbar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.4,
                  child: welcomebar(total, _userTransactions, loggedInUser)),
              Container(
                padding: EdgeInsets.all(10),
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.6,
                child: Consumer<MyModel>(
                  builder: (context, value, child) => TransactionList(
                    value.recentTansactions,
                    _deleteTransaction,
                    //_DateSelect
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _startAddNewTransaction(context),
          label: const Text('Add'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
