import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/home/offreDetails.dart';
import 'package:slouma_v1/views/job/addJob.dart';
import 'package:flutter_skeleton/flutter_skeleton.dart';

import '../../enums.dart';

class ListOffres extends StatelessWidget {
Future<List<dynamic>> getScrapedOffres() async {
    var res = await http.get(Uri.http(Utils.url, Utils.offreTanit)).timeout(const Duration(seconds: 30));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      var response = await http.get(Uri.http(Utils.url, Utils.offre));
      var jdon = json.decode(response.body);
     
      var jsonn=jdon+jsonObj;  
      return jsonn;
    }
  }
  static String routeName = "/list_o";
   List candidates =[String];
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
        title: Text("Jobs"),
      ),
      body: Center(
        child: FutureBuilder <List<dynamic>>(
          future: 
           getScrapedOffres(),
           builder: (context, AsyncSnapshot<List<dynamic>>  snapshot) {
            if (snapshot.data != null) {
              return Scaffold(
                body: new Stack(
                  children: <Widget>[
                    new Center(
                        child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                         return Container(
                         child:InkWell(
                             child: Column(
                children: [
                  Container(
                    child: Column(
                      children: <Widget>[
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(bottom:12.0 ,left:10.0 ,right:10.0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                           children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: SizedBox(
                                          child: ClipRRect(
                                            child: snapshot.data[index]['link']==null ?
                                              Image.network('http://'+Utils.url+'/images/'+snapshot.data[index]['company']+'.png',width: 50,height: 50,):
                                              Image.asset("assets/images/company.png",width: 50,height: 50,),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start, 
                                        children: <Widget>[                                          
                                          Container(
                                              width: 230,
                                              child: Text(
                                              snapshot.data[index]['titre'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                          Container(
                                             width: 230,
                                            child: Text(
                                              snapshot.data[index]['company'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                           Container( width: 230,
                                            child: Text(
                                              snapshot.data[index]['address'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                              snapshot.data[index]['createdAt']!=''?     Container(
                                              child: Text(
                                              snapshot.data[index]['createdAt'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ): SizedBox(),   
                                           Text(
                                           'Be in the first '+snapshot.data[index]['users'].length.toString()+' applicants',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),                                        
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                              onPressed: () => confirtDelete(
                                  snapshot.data[index]['id'], context),
                              tooltip: 'Increment',
                              icon: Icon(Icons.bookmark_border_outlined),
                              color: Colors.grey[600],
                            ),
                                ],      
                              ),
                               Container(
                          margin: EdgeInsets.only(left: 50.0 , top: 10.0),  
                          height: 1.0,
                          color: Colors.grey[300],
                           ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                             onTap: () {
                             showModalBottomSheet(context: context, backgroundColor: Colors.transparent , isScrollControlled: true,  builder: (_) {
                               return DraggableSearchableListView( offre: snapshot.data[index]);
                             },);
                            },
                          ),
                         );
                      }   
                    ))
                  ],
                ),
              );
            } else {
               return CardListSkeleton(
  style: SkeletonStyle(
    theme: SkeletonTheme.Light,
    isShowAvatar: true,
    barCount: 3,
  ),
);
            }
          },
        ),
      ),
  bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
  confirtDelete(id, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("delete"),
              content: Text("are you sure"),
              actions: [
                TextButton(
                  child: Text("yes"),
                  onPressed: () async {
                    print("dddddddddddddddddd" + id);
                    await http.delete(
                        Uri.http(Utils.url, Utils.offre + 'delete/' + id));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ListOffres()));
                  },
                ),
                TextButton(
                  child: Text("no"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  } 
}
