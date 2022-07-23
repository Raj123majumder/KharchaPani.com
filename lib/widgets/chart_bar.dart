import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalspend;
  final double percentspend;

  ChartBar(this.label, this.totalspend, this.percentspend);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20,
            child: FittedBox(
                child: Text("\u{20B9}${totalspend.toStringAsFixed(0)}"))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentspend,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 3, 109, 185),
                          Color(0xff0095FF),
                          Color.fromARGB(231, 132, 196, 241),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
