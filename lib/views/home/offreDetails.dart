import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/constants.dart';
import 'package:slouma_v1/utils/utils.dart';

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

  Apply() async {
    var res = await http.post(Uri.http(Utils.url, Utils.offre));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
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
           
            child: Image.asset("assets/images/hamma.jpeg"),
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
                                          Container(
                                            padding: EdgeInsets.only( top :5),
                                            child: Text(
                                              widget.offre['industry'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0,

                                                color: Colors.black,
                                              ),
                                            ),
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
                                              "Be in the first 25 applicants",
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
                            InkWell(
                              
                              onTap: (){
                                    
                              },
                              child:
                             Container(
                               
              height: 35.0,
              width: 180.0,
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
              width: 180,
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
                          Text(widget.offre['titre'],
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
                       
                         
                          )  ,

                         
                         
                         
                         
                         
                         
                          Container(
                             padding: EdgeInsets.only(bottom: 10.0),
                            height: 300,
                           color: Colors.white,
                          )
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
}
