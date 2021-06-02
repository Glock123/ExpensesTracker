import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double spentAmount;
  final double percOfTotal;
  ChartBar(
      {required this.day,
      required this.spentAmount,
      required this.percOfTotal});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(
                '\u{20B9}${spentAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * (percOfTotal),
                //   decoration: BoxDecoration(
                //     color: Colors.blue,
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                // ),
                FractionallySizedBox(
                  heightFactor: percOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            //     Column(
            //   children: [
            //     Expanded(
            //       flex: ((1 - percOfTotal) * 1000).floor(),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey, width: 1),
            //           color: Color.fromRGBO(220, 220, 220, 0.9),
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       flex: ((percOfTotal) * 1000).floor(),
            //       child: Container(
            //         height: 60 * (percOfTotal),
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).primaryColor,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          // SizedBox(height: constraints.maxHeight * 0.1),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(day)),
          )
        ],
      );
    });
  }
}
