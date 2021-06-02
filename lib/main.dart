import 'package:expenses_tracker/widget/chart.dart';
import 'package:expenses_tracker/widget/new_transaction.dart';
import 'package:expenses_tracker/widget/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/transaction_model.dart';

void main() {
  // Forcing orientation to be portrait always
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              caption: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 17,
              ),
              headline1: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
        cardTheme: CardTheme(
          color: Colors.amber,
          elevation: 10,
          margin: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline1: TextStyle(
                  fontFamily: 'StintUltraCondensed',
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Addidas Shoes',
      amount: 5999,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 500,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String title, String amount, DateTime selectedDate) {
    if (title.isEmpty || double.parse(amount) <= 0) return;
    final newTx = Transaction(
        id: DateTime.now().millisecond.toString(),
        title: title,
        amount: double.parse(amount),
        date: selectedDate);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(final context) {
    showModalBottomSheet(
        context: context,
        builder: (bContext) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTransaction(int idx) {
    setState(() {
      _transactions.removeAt(idx);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    /// Helps in managing state of widget when app is paused, resumed or inactive
    print(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Expenses Tracker',
            style: Theme.of(context).appBarTheme.textTheme!.headline1,
          ),
          actions: [
            IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Chart(recentTransactions: _recentTransactions),
            ),
            Expanded(
              flex: 9,
              child: TransactionList(
                transactions: _transactions,
                deleteTransaction: _deleteTransaction,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () => _startAddNewTransaction(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
