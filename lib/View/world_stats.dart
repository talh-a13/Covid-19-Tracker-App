// ignore_for_file: prefer_const_constructors

import 'package:covid_19/View/Model/world_ModelStats.dart';
import 'package:covid_19/View/Services/utilities/states_services.dart';
import 'package:covid_19/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class covidstats extends StatefulWidget {
  const covidstats({super.key});

  @override
  State<covidstats> createState() => _covidstatsState();
}

class _covidstatsState extends State<covidstats> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final ColorList = [
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  StateServices stateServices = StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            FutureBuilder(
                future: stateServices.fecthworldStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStats> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          controller: _controller,
                          color: Colors.white,
                          size: 50,
                        ));
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot!.data!.cases!.toString()),
                            'Recovered': double.parse(
                                snapshot!.data!.recovered!.toString()),
                            'Deaths': double.parse(
                                snapshot!.data!.deaths!.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          animationDuration: const Duration(milliseconds: 1200),
                          chartType: ChartType.ring,
                          colorList: ColorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(
                                    title: 'Total Cases',
                                    value: snapshot.data!.cases.toString()),
                                ReuseableRow(
                                    title: 'Death',
                                    value: snapshot.data!.deaths.toString()),
                                ReuseableRow(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReuseableRow(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString()),
                                ReuseableRow(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString()),
                                ReuseableRow(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                                ReuseableRow(
                                    title: 'Todays Death',
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => countrieslist()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                'Track Countries',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  ReuseableRow({super.key, required this.title, required this.value});
  String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
