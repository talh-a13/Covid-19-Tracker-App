import 'package:covid_19/View/world_stats.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class detailScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  detailScreen(
      {required this.active,
      required this.critical,
      required this.image,
      required this.name,
      required this.todayRecovered,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.test,
      super.key});

  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height:MediaQuery.of(context).size.height * .06,)
,                      ReuseableRow(
                          title: 'Cases', value: widget.totalCases.toString()),
                                            ReuseableRow(
                          title: 'Recovered', value: widget.todayRecovered.toString())
                          ,                      ReuseableRow(
                          title: 'Death', value: widget.totalDeaths.toString()),
                                                ReuseableRow(
                          title: 'Critical', value: widget.critical.toString())
                          ,                      ReuseableRow(
                          title: 'Today Recovered', value: widget.todayRecovered.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
