import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final Key key;
  final double amount;
  final String title;
  final DateTime date;
  final Function deleteTransaction;
  final int idx;

  const TransactionTile(
      {required this.key,
      required this.amount,
      required this.title,
      required this.date,
      required this.deleteTransaction,
      required this.idx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 10,
      ),
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
              child: Text(
                '\u{20B9}${amount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        subtitle: Text(
          '${DateFormat.yMMMMd().format(date)}',
          style: Theme.of(context).textTheme.headline1,
        ),
        trailing: IconButton(
          color: Colors.red,
          icon: Icon(Icons.delete),
          onPressed: () => deleteTransaction(idx),
        ),
      ),
    );
  }
}
