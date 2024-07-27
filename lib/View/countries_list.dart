import 'package:covid_19/View/Services/utilities/details_screen.dart';
import 'package:covid_19/View/Services/utilities/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class countrieslist extends StatefulWidget {
  const countrieslist({super.key});

  @override
  State<countrieslist> createState() => _countrieslistState();
}

class _countrieslistState extends State<countrieslist> {
  TextEditingController searchController = TextEditingController();
  StateServices stateServices = StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                  hintText: 'Search With Country Name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.CountriesRecordApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detailScreen(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                                  ['totalCases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['totalDeaths'],
                                              totalRecovered:
                                                  snapshot.data![index]
                                                      ['totalRecovered'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => detailScreen(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critical: snapshot.data![index]
                                                  ['critical'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              totalCases: snapshot.data![index]
                                                  ['totalCases'],
                                              totalDeaths: snapshot.data![index]
                                                  ['totalDeaths'],
                                              totalRecovered:
                                                  snapshot.data![index]
                                                      ['totalRecovered'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}
