import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:flutter_session/flutter_session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mapbox_search_flutter/mapbox_search_flutter.dart';
import 'package:slouma_v1/utils/utils.dart';
import 'package:slouma_v1/views/detail_offre/detail_offre.dart';
import 'package:url_launcher/url_launcher.dart';

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,

      child: Container(
        color: Colors.white,
       
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey[700],
                        size: 25,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.more_horiz, size: 35.0,color: Colors.grey[700],),
                const SizedBox(width: 10.0),
                
              ],
            ),
          
          
          ],
        ),
      ),
    );
  }
}

class DraggableSearchableListView extends StatefulWidget {
  final Map offre;
  
  const DraggableSearchableListView({
     
    Key key,
    @required this.offre
  }) : super(key: key);
 

  @override
  _DraggableSearchableListViewState createState() =>
      _DraggableSearchableListViewState();
}

class _DraggableSearchableListViewState extends State<DraggableSearchableListView> {
  final TextEditingController searchTextController = TextEditingController();
  final ValueNotifier<bool> searchTextCloseButtonVisibility =
  ValueNotifier<bool>(false);
  final ValueNotifier<bool> searchFieldVisibility = ValueNotifier<bool>(false);
  MapBoxNavigation _directions;
  MapBoxOptions _options;
   final _destination = WayPoint(
      name: "Way Point 1", 
      latitude: 36.863565,
      longitude: 10.19656);
      String currentUser;
      List candidates =[String];
   String _platformVersion = 'Unknown';
  String _instruction = "";
  bool _arrived = false;
  bool _isMultipleStop = false;
  dynamic user;
  double _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;  Apply() async {
    var res = await http.post(Uri.http(Utils.url, Utils.offre));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }
    fetchPost() async {
    // <------ CHANGED THIS LINE
    var url = Uri.parse(Utils.url2 + '/user/me');

    ///ethi tekhou biha email
    var email = await FlutterSession().get('email');
    print(email.toString());
    final response = await http.post(url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({"username": email}));

    if (response.statusCode == 200) {
      print('RETURNING: ' + response.body);
    
      var jsonObj = json.decode(response.body);
     setState(() {
       currentUser = jsonObj['_id'];
     });
      return jsonObj; // <------ CHANGED THIS LINE
    } else {
      throw Exception('Failed to load post');
    }
  }
  @override
  void initState() {
    super.initState();
    initialize();
     setState(() {
      candidates = widget.offre['users'];
      user = fetchPost();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onEmbeddedRouteEvent);
    _options = MapBoxOptions(
        initialLatitude: double.parse(widget.offre['latitude']) ,
        initialLongitude: double.parse(widget.offre['longitude']),
        zoom: 15.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: true,
        alternatives: true,
        
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
      
        simulateRoute: false,
        animateBuildRoute: true,
        longPressDestinationEnabled: true,
        language: "en");

  
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchTextCloseButtonVisibility.dispose();
    searchFieldVisibility.dispose();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (notification.extent == 1) {
          searchFieldVisibility.value = true;
         
        } else {
          searchFieldVisibility.value = false;
           stderr.writeln(notification.extent);
        }
        return true;
      },
      child: DraggableScrollableActuator(
        child: Stack(
          children: <Widget>[
           
            DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.9,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                 
                 decoration: BoxDecoration(
                     color:Color(0xfff1eee4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, -2.0),
                          blurRadius: 4.0,
                          spreadRadius: 2.0)
                    ],
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 2,
                    ///we have 25 rows plus one header row.  
                    
                    itemBuilder: (BuildContext context, int index) {
                      
                      if (index == 0) {
                        return Container(
                         decoration: BoxDecoration(
                     color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    )),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                
                                 child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.more_horiz, size: 35.0,color: Colors.grey[700],),
                const SizedBox(width: 10.0),
                
              ],
            ),
          
          
          ],
                                     
                                  
                                   )
                                 
                                ),
                              
                              SizedBox(
                                height: 10.0,
                              ),
                                 Container(
                         height: 1.0,
                         color: Colors.grey[300],
                        ),
                            ],
                          ),
                        ); 
                      }
                    
                        
                 
               return  Container(
                        
                          child: Column(
                            
                            children: [

                             Container(
                             padding: EdgeInsets.all(20.0), 
                             margin: EdgeInsets.only(bottom: 10.0),
                         
                           color: Colors.white,
                           child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                              
                                  children: <Widget> [
                                      Row(
         crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
               SizedBox(
          height: 60.0,
          width: 60.0,
          child: ClipRRect(
           child: widget.offre['link']==null ?Image.network('http://'+Utils.url+'/images/'+widget.offre['company']+'.png',width: 50,height: 50,): Image.asset("assets/images/company.png",width: 50,height: 50,),
          ),
        ),
                Text(
                                       "3 days" + " ago",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.0,
                                          color: Colors.grey,
                                        ),
                                      ),
         ],
                               ),

                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          
                                        children: [
                                          
                                          Container(
                                            padding: EdgeInsets.only( top :25),
                                            child: Text(
                                               widget.offre['titre'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 19.0,
                                                color: Colors.black
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            child: Container(
                                              padding: EdgeInsets.only( top :5),
                                              child: Text(
                                                widget.offre['company'],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.0,

                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              String nomCmp = widget
                                                      .offre["company"];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailOffre(
                                                                idC: nomCmp)),
                                                  );
                                            },
                                          ),
                                           Container(
                                              padding: EdgeInsets.only( top :3),
                                            child: Text(
                                              widget.offre['address'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13.5,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Container(
                                        padding: EdgeInsets.only( top :3 , bottom: 10) ,
                                            child: Text(
                                             'Be in the first '+candidates.length.toString()+' applicants',
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 13.5,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        
                                    
                                        
                                        ],
                                      ),
                                      
                                   Expanded (
                                     flex: 0,
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                  children: <Widget>[
                    
 widget.offre['link']==null ? 
 candidates.contains(currentUser)?

                
                                
                                      Text(
                    "Already applied",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  :
                       Row(children: [ InkWell(
                              
                                   onTap: () {
     
                            Map<String, dynamic> cardata = {
                              "idUser": currentUser,
                              "idOffre": widget.offre['_id'],
                            
                            };
                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };
                            var url = Uri.parse(Utils.url2 + '/offre/apply/new');
                            http
                                .post(url,
                                    headers: headers,
                                    body: json.encode(cardata))
                                .then((http.Response reponse) {
                              if (reponse.statusCode == 200) {
                                print(user);
                             setState(() {
                               candidates.add(currentUser);
                             });
                              }
                              String message = reponse.statusCode == 200
                                  ? "job added"
                                  : "error";
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("info"),
                                    content: Text(message),
                                  );
                                },
                              );
                            });
                          } 
                        ,
                
                              child:
                             Container(
                       margin:EdgeInsets.only(right:10) ,        
              height: 35.0,
              width: 160.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Colors.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                
                  Text(
                    "Apply now",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      
                    ),
                  ),
                ],
              ),
            ),
                 ),
                   
                    InkWell (
                      onTap: () {},
                      
                      child: Container(
              height: 35.0,
              width: 174,
              decoration: BoxDecoration(
                 border: Border.all(color: Colors.pink),
                borderRadius: BorderRadius.circular(60.0),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                
                  Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 18.0,
                      color:Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
                                   
                     
                    ) 
                                 
                      ],)
                 :      
                       Row(children: [ InkWell(
                              
                                   onTap: () {
     
                            launch(widget.offre['link']);
                          } 
                        ,
                
                              child:
                             Container(
                               
              height: 35.0,
              width: 220.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                color: Colors.pink,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                
                  Text(
                    "Apply On Tanit Jobs",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
                 ),
                   
                            
                      ],)
            
                                  ],
                                ),
                              ),    
                                 
                           ],
                           ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ 
                        
                          Container(
                          width: 400,  
                          margin: EdgeInsets.only(bottom:12),  
                          child: 
                            Text(
                          "Job Description",
                           style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                          ),
                         
                          ),
                          Text(widget.offre['description'],
                           style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                          )
                          ],
                          ),  
                           color: Colors.white,
                          ),
                             
                  widget.offre['link']==null?  
                        IntrinsicWidth(
                            child :     Container(
                          width: 800,     
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 10.0),
                          child: Column(
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                            
                            children: [ 
                        
                          Container(
                          margin: EdgeInsets.only(bottom:12),  
                          child: 
                            Text(
                          "Job Details",
                           style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                          ),
                         
                          ),
                          Column(
                            
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                               Text(
                          "Employement",
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                          ),
                           Text(
                          widget.offre['jobTime'],
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                          ),
                          ]
                         
                         
                          ),
                           Column(
                            
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                               Text(
                          "Job Function",
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  height: 2.5,
                                ),
                          ),
                           Text(
                          widget.offre['poste'],
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                          ),
                          ]
                         
                         
                          ),
                             Column(
                            
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                               Text(
                          "Industry",
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  height: 2.5,
                                ),
                          ),
                           Text(
                          widget.offre['industry'],
                           style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                  color: Colors.grey,
                                  height: 1.4,
                                ),
                          ),
                          ]
                         
                         
                          ),
                        
                          ],
                          ),  
                           color: Colors.white,
                          ),
                       
                         
                          ) :SizedBox() ,

                         widget.offre['link']==null?  
                         Column(
          children: [
    MapBoxPlaceSearchWidget(
          height: 300,
         
          apiKey: "pk.eyJ1IjoiYXltYW5ubiIsImEiOiJja3BuZHVrZ2QybzM2MndyaXEwamxuZDVqIn0.6GM7CF90UWngIGU66viGDw",
          searchHint: 'Set Your address',
          onSelected: (place) {  if(_routeBuilt){
                                   _controller.clearRoute();
                                   var wayPoints = <WayPoint>[];                                   
                                   wayPoints.add(WayPoint(name: place.placeName, latitude: place.geometry.coordinates[1], longitude: place.geometry.coordinates[0]));   
                                  wayPoints.add(WayPoint(name: widget.offre['address'],latitude : double.parse(widget.offre['latitude']), longitude: double.parse(widget.offre['longitude'])));                                           
                                   _controller.buildRoute(wayPoints: wayPoints);
                              
          }else{
                                   var wayPoints = <WayPoint>[];                                   
                                   wayPoints.add(WayPoint(name: place.placeName, latitude: place.geometry.coordinates[1], longitude: place.geometry.coordinates[0]));   
                                   wayPoints.add(WayPoint(name: widget.offre['address'],latitude : double.parse(widget.offre['latitude']), longitude: double.parse(widget.offre['longitude'])));                                                 
                                   _controller.buildRoute(wayPoints: wayPoints);
                              
          }
                                  
                                
                                   },
          context: context,
        ),
          Container(
            
            height: 450,
                 color: Colors.grey,
                 child: MapBoxNavigationView(
                     options: _options,
                     onRouteEvent: _onEmbeddedRouteEvent,
                     onCreated:
                         (MapBoxNavigationViewController controller) async {
                       _controller = controller;
                       controller.initialize();
                     }),
               ),
          ],

   
                         )
                         :
                         SizedBox()

                         
                         
                      ],
                          ));
              },
                  
                  ),
                );
              },
            ),
            
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: ValueListenableBuilder<bool>(
                  valueListenable: searchFieldVisibility,
                  builder: (context, value, child) {
                    return value
                        ? PreferredSize(
                            preferredSize: Size.fromHeight(56.0),
                            child: Container(
                             
                              padding: EdgeInsets.only(top:30.0 ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color: Theme.of(context).dividerColor),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: _TopBar(),
                            ),
                          )
                        : Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
   Future<void> _onEmbeddedRouteEvent(e) async {
    _distanceRemaining = await _directions.distanceRemaining;
    _durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
  
}
class SearchPage extends StatelessWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        bottom: false,
        child: MapBoxPlaceSearchWidget(
          popOnSelect: true,
          apiKey: "pk.eyJ1IjoiYXltYW5ubiIsImEiOiJja3BuZHVrZ2QybzM2MndyaXEwamxuZDVqIn0.6GM7CF90UWngIGU66viGDw",
          searchHint: 'Search around',
          onSelected: (place) {},
          context: context,
        ),
      ),
    );
  }
}