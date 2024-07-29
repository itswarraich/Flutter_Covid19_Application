import 'package:covid_flutter_application/services/states_services.dart';
import 'package:covid_flutter_application/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatesServices statesServices=StatesServices();

  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  contentPadding:const EdgeInsets.symmetric(horizontal: 20),
                  //suffixIcon:Icons.search,
                  hintText: "Search Countries",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),

            Expanded(
                child: FutureBuilder(
                  future:statesServices.countryListApi (),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if (!snapshot.hasData) {
                      return  ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context,index){
                            return ShimmerEffect(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                 child: Column(
                                   children: [
                                     ListTile(
                                       title: Container(height: 10 , width: 80, color: Colors.white,),
                                       subtitle: Container(height: 10 , width: 80, color: Colors.white,),
                                       leading: Container(height: 10 , width: 80, color: Colors.white,),
                                     ),

                                   ],
                                 ),
                            );


                          });
                    } else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                          String name= snapshot.data![index]['country'];
                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              todayRecovered: snapshot.data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              active: snapshot.data![index]['active'],
                                              test: snapshot.data![index]['tests'],
                                              totalRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index]['critical'],

                                            )));
                                    },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                ),

                              ],
                            );

                          } else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              todayRecovered: snapshot.data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              active: snapshot.data![index]['active'],
                                              test: snapshot.data![index]['tests'],
                                              totalRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index]['critical'],

                                            )));

                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                ),

                              ],
                            );
                          } else{
                            return Container();

                          }


                          });
                    }


                  },
                )),

        ],),
      ),
    );
  }
}
