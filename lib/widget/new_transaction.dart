import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final addNewTransactionMethod;

  NewTransaction(this.addNewTransactionMethod);

  @override
  _NewTransactionState createState() {
    print('createState New Transaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  // These are the controllers attatched to textInput to get/set text
  final commodityController = TextEditingController();
  final priceController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isDateSelected = false;

  @override
  void initState() {
    // Running inital codes for current widget
    // Eg. getting data from webservers
    super.initState();
    //print('initState() New Transaction');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // Used to track some changes in the widget
    super.didUpdateWidget(oldWidget);
    //print('didUpdateWidget() New Transaction');
  }

  @override
  void dispose() {
    // Use for cleaning up widget before it gets closed, maybe
    // shut down connecttion with online server, or to save
    // some current data.
    super.dispose();
    //print('dispose() New Transaction');
  }

  void addTransaction() {
    // Adding new transaction to list
    if (commodityController.text.isEmpty ||
        double.parse(priceController.text) <= 0 ||
        !_isDateSelected) return;
    widget.addNewTransactionMethod(
        commodityController.text, priceController.text, _selectedDate);

    // Clearing the text fields
    commodityController.text = "";
    priceController.text = "";

    // To pop off the modal sheet since it is the topmost widget on screen
    // context is made available even though we have not defined
    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(DateTime.now().year - 1),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _isDateSelected = true;
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: commodityController,
              onSubmitted: (_) => addTransaction(),
              decoration: InputDecoration(
                labelText: 'Enter commodity',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTransaction(),
              decoration: InputDecoration(
                labelText: 'Enter price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                Expanded(
                  flex: 1,
                  // ignore: unnecessary_null_comparison
                  child: Text(
                    _isDateSelected == false
                        ? 'No date selected...'
                        : 'Picked date: ${DateFormat.yMMMMd().format(_selectedDate)}',
                  ),
                ),
                OutlinedButton(
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text('Select Date')),
              ]),
            ),
            ElevatedButton(
              onPressed: addTransaction,
              child: Text('Add Expense'),
            )
          ],
        ),
      ),
    );
  }
}
