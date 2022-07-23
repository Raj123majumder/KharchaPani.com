import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  //final _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final today = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: DateTime(1900, 1),
      lastDate: today,
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _onSubmit() {
    final title = _titlecontroller.text;
    final amt = double.parse(_amountcontroller.text);

    if (title.isEmpty || amt <= 0 || _selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  "Invalid Format!!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                content: Text("Either text empty or amount negative"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("OK"))
                ],
              ));
      return;
    }

    widget.addTx(
      _titlecontroller.text,
      double.parse(_amountcontroller.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextFormField(
            controller: _titlecontroller,
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              prefixIcon: Icon(Icons.title),
              hintText: "Enter a title",
            ),
            keyboardType: TextInputType.text,
            onFieldSubmitted: (_) => _onSubmit(),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(
            height: 12,
          ),
          TextFormField(
            controller: _amountcontroller,
            decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                prefixIcon: Icon(MdiIcons.currencyInr),
                hintText: "Enter the Amount"),
            keyboardType: TextInputType.number,
            onFieldSubmitted: (_) => _onSubmit(),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  height: 51,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(
                        width: 10,
                      ),
                      Text(_selectedDate == null
                          ? "No Date"
                          : DateFormat.yMMMd().format(_selectedDate))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: MaterialButton(
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: () => _selectDate(context),
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
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
            onPressed: _onSubmit,
            child: Text('Add'),
          )
        ]),
      ),
    );
  }
}
