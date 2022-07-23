import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import '../widgets/Indicator.dart';

class WeekPieChart extends StatefulWidget {
  final List<Transactions> _transactions;
  const WeekPieChart({Key? key, required List<Transactions> transactions})
      : _transactions = transactions,
        super(key: key);

  @override
  _WeekPieChartState createState() => _WeekPieChartState();
}

class _WeekPieChartState extends State<WeekPieChart> {
  List<double> _spendings = List.generate(7, (index) => 0);

  void _generateWeeklyReport() {
    if (_spendings.isNotEmpty) {
      _spendings.clear();
      _spendings = List.generate(7, (index) => 0);
    }
    for (Transactions transaction in widget._transactions) {
      _spendings[transaction.date.weekday - 1] += transaction.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    _generateWeeklyReport();
    return widget._transactions.isEmpty == true
        ? Card(
            margin: EdgeInsets.all(20),
            elevation: 7,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Pie Chart',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.4,
                        ),
                        padding: EdgeInsets.all(10),
                      ),
                      Expanded(child: Container()),
                      Center(
                        child: Text(
                          'No Transactions!!',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Indicator(
                            color: Color(0xff0095FF),
                            text: 'Mon',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color.fromARGB(255, 4, 108, 182),
                            text: 'Tue',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.grey,
                            text: 'Wed',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.green,
                            text: 'Thu',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.brown,
                            text: 'Fri',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.blue,
                            text: 'Sat',
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Colors.black,
                            text: 'Sun',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Card(
            elevation: 7,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Pie Chart',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    child: Divider(
                      color: Colors.black,
                      thickness: 0.4,
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  //Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //Expanded(child: Container()),
                      Flexible(
                        flex: 2,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 3.0,
                              centerSpaceRadius: 10,
                              startDegreeOffset: 130.0,
                              borderData: FlBorderData(
                                  border: Border.all(), show: false),
                              sections: [
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color(0xff0095FF),
                                  value: _spendings[0],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 4, 108, 182),
                                  value: _spendings[1],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 59, 150, 215),
                                  value: _spendings[2],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 6, 79, 169),
                                  value: _spendings[3],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 18, 198, 211),
                                  value: _spendings[4],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 5, 50, 213),
                                  value: _spendings[5],
                                  radius: 75.0,
                                ),
                                PieChartSectionData(
                                  showTitle: false,
                                  color: Color.fromARGB(255, 234, 240, 245),
                                  value: _spendings[6],
                                  radius: 75.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Expanded(child: Container()),
                      Flexible(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Indicator(
                              color: Color(0xff0095FF),
                              text: 'Mon',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Color.fromARGB(255, 4, 108, 182),
                              text: 'Tue',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.grey,
                              text: 'Wed',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.green,
                              text: 'Thu',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.brown,
                              text: 'Fri',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.blue,
                              text: 'Sat',
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Indicator(
                              color: Colors.black,
                              text: 'Sun',
                            ),
                          ],
                        ),
                      ),
                      //Expanded(child: Container()),
                    ],
                  ),
                  //Expanded(child: Container()),
                ],
              ),
            ),
          );
  }
}





// Card(
//             margin: EdgeInsets.all(20),
//             elevation: 7,
//             child: Stack(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Text(
//                         'Pie Chart',
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Padding(
//                         child: Divider(
//                           color: Colors.black,
//                           thickness: 0.4,
//                         ),
//                         padding: EdgeInsets.all(10),
//                       ),
//                       Expanded(child: Container()),
//                       Expanded(
//                         child: PieChart(
//                           PieChartData(
//                             sectionsSpace: 3.0,
//                             centerSpaceRadius: 10,
//                             startDegreeOffset: 130.0,
//                             borderData:
//                                 FlBorderData(border: Border.all(), show: false),
//                             sections: [
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color(0xff0095FF),
//                                 value: _spendings[0],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 4, 108, 182),
//                                 value: _spendings[1],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 59, 150, 215),
//                                 value: _spendings[2],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 6, 79, 169),
//                                 value: _spendings[3],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 18, 198, 211),
//                                 value: _spendings[4],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 5, 50, 213),
//                                 value: _spendings[5],
//                                 radius: 75.0,
//                               ),
//                               PieChartSectionData(
//                                 showTitle: false,
//                                 color: Color.fromARGB(255, 234, 240, 245),
//                                 value: _spendings[6],
//                                 radius: 75.0,
//                               ),
//                             ],
//                           ),
//                           // swapAnimationDuration: Duration(milliseconds: 150), // Optional
//                           // swapAnimationCurve: Curves.linear,
//                         ),
//                       ),
//                       Expanded(child: Container()),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         mainAxisSize: MainAxisSize.max,
//                         children: <Widget>[
//                           Indicator(
//                             color: Color(0xff0095FF),
//                             text: 'Mon',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Color.fromARGB(255, 4, 108, 182),
//                             text: 'Tue',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Colors.grey,
//                             text: 'Wed',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Colors.green,
//                             text: 'Thu',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Colors.brown,
//                             text: 'Fri',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Colors.blue,
//                             text: 'Sat',
//                           ),
//                           SizedBox(
//                             height: 4,
//                           ),
//                           Indicator(
//                             color: Colors.black,
//                             text: 'Sun',
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );