import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:slouma_v1/components/form_error.dart';
import 'package:slouma_v1/views/home/ListOffres.dart';

class AddCar extends StatefulWidget {
  @override
  _AddCarState createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  final _formKey = GlobalKey<FormState>();
  String title;
  String company;
  String address;
  String type;
  String description;
  String position;
  String salary;
  List<String> errors = [];
  List<String> currenciesList = [
    'FullTime',
    'PartTime',
    'Intership',
    'Contract',
  ];
  TextEditingController _textController;
  double total = 1;
  int selectedValue;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    super.initState();
  }

  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .25,
          child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (index) {
                setState(() {
                  type = currenciesList[index].toString();
                });
              },
              children: [
                for (String name in currenciesList) Center(child: Text(name)),
              ]),
        );
      },
    );
  }

  GlobalKey<FormState> myKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.black,
              height: 0.2,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: const Text('Create new job'),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    child: Text(
                  "Add job details",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21.0,
                      color: Colors.black,
                      height: 1.34),
                )),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job title *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      SizedBox(
                        height: 35,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: 'Optional note',
                          ),
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                            if (value.isNotEmpty) {
                              _formKey.currentState.validate();
                              removeError(
                                  error: "this field should not be hamma");
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "this field should not be hamma");
                              return "";
                            } else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Company *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        height: 35,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: 'Optional note',
                          ),
                          onChanged: (value) {
                            setState(() {
                              company = value;
                            });
                            if (value.isNotEmpty) {
                              _formKey.currentState.validate();
                              removeError(
                                  error: "this field should not be empty");
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "this field should not be empty");
                              return "";
                            } else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        height: 35,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: 'Optional note',
                          ),
                          onChanged: (value) {
                            setState(() {
                              address = value;
                            });
                            if (value.isNotEmpty) {
                              _formKey.currentState.validate();
                              removeError(
                                  error: "this field should not be empty");
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "this field should not be empty");
                              return "";
                            } else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Salary *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        height: 35,
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            // ignore: deprecated_member_use
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: 'Optional note',
                          ),
                          onChanged: (value) {
                            setState(() {
                              salary = value;
                            });
                            if (value.isNotEmpty) {
                              _formKey.currentState.validate();
                              removeError(
                                  error: "this field should not be empty");
                            } else
                              return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "this field should not be empty");
                              return "";
                            } else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Position *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        height: 35,
                        child: TextFormField(
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(height: 0),
                            hintText: 'Optional note',
                          ),
                          onChanged: (value) {
                            setState(() {
                              position = value;
                            });
                            if (value.isNotEmpty) {
                              _formKey.currentState.validate();
                              removeError(
                                  error: "this field should not be empty");
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              addError(error: "this field should not be empty");
                              return "";
                            } else
                              return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Job Type *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          onTap: () => {
                            _tripEditModalBottomSheet(context),
                          },
                          controller: TextEditingController()..text = type,
                          decoration: new InputDecoration(
                            hintText: 'Optional note',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description *",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.grey,
                            height: 1.34),
                      ),
                      Container(
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: true,
                            child: SizedBox(
                              height: 50.0,
                              child: new TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    description = value;
                                  });
                                  if (value.isNotEmpty) {
                                    _formKey.currentState.validate();
                                    removeError(
                                        error:
                                            "this field should not be empty");
                                  }
                                  return null;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    addError(
                                        error:
                                            "this field should not be empty");
                                    return "";
                                  } else
                                    return null;
                                },
                                maxLines: 100,
                                decoration: new InputDecoration(
                                  errorStyle: TextStyle(height: 0),
                                  hintText: 'Add your text here',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                FormError(errors: errors),
              ],
            ),
          )),
      bottomNavigationBar: new BottomAppBar(
          elevation: 50,
          child: Container(
              height: 55,
              child: Column(
                children: [
                  Container(
                    height: 1.5,
                    color: Colors.grey[300],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Map<String, dynamic> cardata = {
                              "titre": title,
                              "description": description,
                              "poste": "Senior",
                              "address": address,
                              "creator": "admin",
                              "industry": company,
                              "company": company,
                              "type": type,
                              "jobTime": type,
                              "salary": "2000",
                              "longitude": "3.613140",
                              "latitude": "36.400512"
                            };
                            Map<String, String> headers = {
                              "Content-Type": "application/json; charset=UTF-8"
                            };
                            http
                                .post("http://localhost:3000/offre/Newoffre",
                                    headers: headers,
                                    body: json.encode(cardata))
                                .then((http.Response reponse) {
                              if (reponse.statusCode == 201) {
                                Navigator.pushNamed(
                                    context, ListOffres.routeName);
                              }
                              String message = reponse.statusCode == 201
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
                          } else {
                            print('fokk aad');
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 30.0,
                          width: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.pink,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Post job for free",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }
}
