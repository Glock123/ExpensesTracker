import 'package:expenses_tracker/model/transaction_model.dart';
import 'package:expenses_tracker/widget/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recentTransactions;
  Chart({required this.recentTransactions});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totSum = 0;
      for (int i = 0; i < widget.recentTransactions.length; ++i) {
        if (widget.recentTransactions[i].date.day == weekDay.day &&
            widget.recentTransactions[i].date.month == weekDay.month &&
            widget.recentTransactions[i].date.year == weekDay.year) {
          totSum += widget.recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totSum};
    }).reversed.toList();
  }

  double get totalSumThisWeek {
    return groupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue += (element['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    Size sizeOfScreen = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        print(
            'Contraints ${constraints.maxHeight} height and ${constraints.maxWidth} width');
        print(
            'Total ${sizeOfScreen.height} height and ${sizeOfScreen.width} width');
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map(
                (item) {
                  return Expanded(
                    flex: 1,
                    child: ChartBar(
                        day: item['day'].toString(),
                        spentAmount: (item['amount'] as double),
                        percOfTotal: (item['amount'] as double) /
                            (totalSumThisWeek + 0.01)),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
