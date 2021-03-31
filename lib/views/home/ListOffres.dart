import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:slouma_v1/utils/utils.dart';

import 'package:slouma_v1/views/home/offreDetails.dart';

import '../../enums.dart';

class ListOffres extends StatelessWidget {
  getOffres() async {
    var res = await http.get(Uri.http(Utils.url, Utils.offre));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  static String routeName = "/list_o";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getOffres(),
          builder: (context, snapshot) {
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
          height: 50.0,
          width: 50.0,
          child: ClipRRect(
           
            child: Image.asset("assets/images/hamma.jpeg"),
          ),
        ),
                                      ),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        
                                        children: <Widget>[
                                          
                                          Container(
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
                                            child: Text(
                                              snapshot.data[index]['industry'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,

                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                           Container(
                                            child: Text(
                                              snapshot.data[index]['address'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              snapshot.data[index]['titre'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 12.0,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          
                                          Text(
                                            snapshot.data[index]['titre'] +" . "+ " Edited",
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
              return Center(child: Text("hi ena list offre wahdi"));
            }
          },
        ),
      ),
      //bottomNavigationBar:
        //  CustomBottomNavBar(selectedMenu: MenuState.favourite),
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
   void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return  Container (
          height: MediaQuery.of(context).size.height * .80,
          child: Padding(
            
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Height"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.orange,
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                     'hamma Dine',
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
               Row(
                  children: [
                    Text(
                     'hamma Dine',
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
               Row(
                  children: [
                    Text(
                     'hamma Dine',
                      style: TextStyle(fontSize: 30, color: Colors.green[900]),
                    ),
                  ],
                ),
             
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Submit'),
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                      onPressed: () async {
                       
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Delete'),
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          
        );
      },
    );
  }

}
