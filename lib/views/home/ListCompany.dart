import 'dart:convert';
import 'package:slouma_v1/views/detail_offre/detail_offre.dart';
import 'package:slouma_v1/views/home/offreDetails.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slouma_v1/components/coustom_bottom_nav_bar.dart';
import 'package:slouma_v1/enums.dart';
import "package:slouma_v1/utils/utils.dart";
import 'package:slouma_v1/views/chatbot_help/chatbot.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ListCompany extends StatefulWidget {
  static String routeName = "/list_c";
  ListCompany({Key key}) : super(key: key);

  @override
  _ListCompanyState createState() => _ListCompanyState();
}

class _ListCompanyState extends State<ListCompany> {
  String idCompany;
  final pageViewController = PageController();
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  getCompanies() async {
    var res = await http.get(Uri.http(Utils.url, Utils.company));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  getOffres() async {
    var res = await http.get(Uri.http(Utils.url, Utils.offre));
    if (res.statusCode == 200) {
      var jsonObj = json.decode(res.body);
      return jsonObj;
    }
  }

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
  };

  // ignore: missing_return

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                    child: Container(
                      width: 50,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        'https://picsum.photos/seed/204/600',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: '  Search',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 10,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 10,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Chatbot.routeName);
                    },
                    icon: Icon(
                      Icons.message,
                      color: Colors.black,
                      size: 30,
                    ),
                    iconSize: 30,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
                color: Colors.pink,
                height: 5,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 500,
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child: PageView(
                          controller: pageViewController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: FutureBuilder(
                                  future: getOffres(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            // current the spelling of length here
                                            shrinkWrap: true,

                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                child: Card(
                                                    margin: EdgeInsets.only(
                                                        bottom: 10,
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0),
                                                    child: Column(
                                                      children: [
                                                        Image.network(
                                                          'https://picsum.photos/id/1/789/300',
                                                          width:
                                                              double.infinity,
                                                          height: 110,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(15, 15,
                                                                  15, 25),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      snapshot.data[
                                                                              index]
                                                                          [
                                                                          'titre'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            8,
                                                                            0,
                                                                            0),
                                                                child: Text(snapshot
                                                                            .data[index]
                                                                        [
                                                                        'description'] +
                                                                    "\n" +
                                                                    "Timing : " +
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'jobTime'] +
                                                                    "\n" +
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'description'] +
                                                                    "\n" +
                                                                    "Salary : " +
                                                                    snapshot.data[
                                                                            index]
                                                                        [
                                                                        'salary']),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    isScrollControlled: true,
                                                    builder: (_) {
                                                      return DraggableSearchableListView(
                                                          offre: snapshot
                                                              .data[index]);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        : const CircularProgressIndicator();
                                  }),
                            ),
                            Card(
                              margin: EdgeInsets.only(
                                  bottom: 10,
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0),
                              child: FutureBuilder(
                                  future: getCompanies(),
                                  builder: (context, snapshot) {
                                    return snapshot.hasData
                                        ? ListView.builder(
                                            // current the spelling of length here
                                            shrinkWrap: true,

                                            itemCount: snapshot.data.length,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                child: Card(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10,
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 10.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.network(
                                                            'http://192.168.1.26:3000/uploads/${snapshot.data[index]["nom"]}.png',
                                                            width: 100,
                                                            height: 50,
                                                            fit: BoxFit.cover,
                                                          ),
                                                          Text(snapshot
                                                                  .data[index]
                                                              ["nom"])
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                onTap: () {
                                                  String nomCmp = snapshot
                                                      .data[index]["nom"];
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailOffre(
                                                                idC: nomCmp)),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        : const CircularProgressIndicator();
                                  }),
                            ),
                            Card(
                              child: null,
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment(0, 1),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: SmoothPageIndicator(
                            controller: pageViewController,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            onDotClicked: (i) {
                              pageViewController.animateToPage(
                                i,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            effect: ExpandingDotsEffect(
                              expansionFactor: 2,
                              spacing: 8,
                              radius: 16,
                              dotWidth: 16,
                              dotHeight: 16,
                              dotColor: Color(0xFF9E9E9E),
                              activeDotColor: Colors.pink,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
