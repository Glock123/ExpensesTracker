import 'package:expenses_tracker/model/transaction_model.dart';
import 'package:expenses_tracker/widget/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final deleteTransaction;
  TransactionList(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              const Text(
                'No transactions!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Image.asset(
                  'assets/images/waiting1.png',
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (ctx, idx) {
              //   return Container(
              //     margin: EdgeInsets.symmetric(
              //       vertical: 10,
              //       horizontal: 5,
              //     ),
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Colors.black,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Expanded(
              //           flex: 2,
              //           child: Container(
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                   color: Theme.of(context).primaryColor),
              //               borderRadius: BorderRadius.circular(10),
              //             ),
              //             margin: EdgeInsets.only(
              //               right: 7,
              //               left: 5,
              //             ),
              //             padding: EdgeInsets.all(10),
              //             child: Center(
              //               child: Text(
              //                 'Rs ${transactions[idx].amount.toStringAsFixed(2)}',
              //                 style: TextStyle(
              //                     fontSize: 16,
              //                     color: Colors.purple,
              //                     fontFamily: 'Quicksand',
              //                     fontWeight: FontWeight.w900),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           flex: 3,
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text(
              //                 transactions[idx].title,
              //                 style: Theme.of(context).textTheme.caption,
              //               ),
              //               SizedBox(
              //                 height: 10,
              //               ),
              //               Text(
              //                 '${DateFormat.yMMMMd().format(transactions[idx].date)}',
              //                 style: Theme.of(context).textTheme.headline1,
              //               )
              //             ],
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: null,
              //           icon: Icon(
              //             Icons.delete,
              //             color: Colors.red,
              //           ),
              //         ),
              //       ],
              //     ),
              //   );
              // },
              return TransactionTile(
                  key: UniqueKey(),
                  amount: transactions[idx].amount,
                  title: transactions[idx].title,
                  date: transactions[idx].date,
                  deleteTransaction: deleteTransaction,
                  idx: idx);
            },
          );
  }
}
