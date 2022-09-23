import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user.dart';

class second extends StatefulWidget {
  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  List map = [];

  Future viewdata() async {
    var url =
        Uri.parse('https://pdfile7.000webhostapp.com/firstdata/viewdata1.php?');
    var response = await http.get(url);
    print(response.body);
    map = jsonDecode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd9d9d9),
      body: SafeArea(
        top: true,
        child: Container(
          margin: EdgeInsets.only(right: 6, left: 6),
          child: Column(
            children: [
              Ink(
                child: Center(
                    child: Text(
                  "ALL CATEGORY",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff4d4d4d),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              Expanded(
                child: FutureBuilder(
                  future: viewdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                          itemBuilder: (context, index) {
                            user u = user.fromJson(map[index]);
                            return Container(
                              margin: EdgeInsets.only(top: 9, bottom: 9),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              child: InkWell(
                                onLongPress: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        elevation: 10,
                                        children: [
                                          Column(
                                            children: [
                                              Text("Are shure!!."),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                              fixedSize: Size(70, 30),
                                                              onSurface: Colors.purpleAccent,
                                                              primary: Colors.green),
                                                      onPressed: () async {
                                                        var url = Uri.parse(
                                                            'https://pdfile7.000webhostapp.com/firstdata/deletedata1.php?id=${u.id}');
                                                        var response = await http.get(url);
                                                        print(response.body);

                                                        print("\n\nHarik\n\n");
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Text("Delete")),
                                                  TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                              fixedSize:
                                                                  Size(70, 30),
                                                              onSurface: Colors.purpleAccent,
                                                              primary: Colors.green),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel")),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                        title: Text("Delete your data"),
                                      );
                                    },
                                  );
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Name: ${u.name}"),
                                    ),
                                    ListTile(
                                      title: Text("Type: ${u.type}"),
                                    ),
                                    ListTile(
                                      title:
                                          Text("description: ${u.description}"),
                                    ),
                                    ListTile(
                                      title: Text("Minimum Qty: ${u.qty}"),
                                    )
                                  ],
                                  // backgroundColor: c,
                                ),
                              ),
                            );
                          },

                          itemCount: map.length);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}