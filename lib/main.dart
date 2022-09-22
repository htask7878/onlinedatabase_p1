import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'second.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: home(),
  ));
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  dynamic type, cat_type, cat_name, cat_description, cat_qty;
  bool ty = false;
  Color c = Color(0xffe9e9e9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(right: 5, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Ink(
                  child: Center(
                      child: Text(
                    "ADD CATEGORY",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff4d4d4d),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text("Name : ",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.start),
                  height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Ink(
                    height: 40,
                    color: Color(0xffe9e9e9),
                    child: TextField(
                        controller: t1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ))),
                SizedBox(height: 10),
                SizedBox(
                  child: Text("Type ",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.start),
                  // height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio(
                      value: "vegetarian",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value;
                          ty = true;
                        });
                      },
                    ),
                    Text("vege.", style: TextStyle(fontSize: 10)),
                    Radio(
                      value: "Non-vegetarian",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value;
                          ty = true;
                        });
                      },
                    ),
                    Text("Non-vege.", style: TextStyle(fontSize: 10)),
                    Radio(
                      value: "Eggatarian",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value;
                          ty = true;
                        });
                      },
                    ),
                    Text("Eggata.", style: TextStyle(fontSize: 10)),
                    Radio(
                      value: "vegan",
                      groupValue: type,
                      onChanged: (value) {
                        setState(() {
                          type = value;
                          ty = true;
                        });
                      },
                    ),
                    Text("vegan", style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text("Description",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.start),
                  height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Ink(
                    height: 80,
                    color: Color(0xffe9e9e9),
                    child: TextField(
                        controller: t2,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ))),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Text("minimum qty",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.start),
                  height: 20,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    height: 70,
                    width: 70,
                    color: Color(0xffe9e9e9),
                    child: TextField(
                        controller: t3,
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        ))),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 45),
                        onPrimary: Colors.purpleAccent,
                        primary: Color(0xff4d4d4d)),
                    onPressed: () async {
                      cat_name = t1.text;
                      cat_type = type;
                      cat_description = t2.text;
                      cat_qty = t3.text;
                      print("name = $cat_name");
                      print("type = $cat_type");
                      print("desc = $cat_description");
                      print("qty = $cat_qty");

                      var url = Uri.parse(
                          'https://pdfile7.000webhostapp.com/firstdata/getdata1.php?cat_type=$cat_type&cat_name=$cat_name&cat_description=$cat_description&cat_qty=$cat_qty');
                      var response = await http.get(url);
                      print('Response body: ${response.body}');

                      // Map  m=jsonDecode(response.body);
                      // print(m['cat_type']);
                      // print(m['cat_name']);
                      // print(m['cat_description']);
                      // print(m['cat_qty']);

                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return second();
                        },
                      ));
                      setState(() {});

                      t1.text = "";
                      t2.text = "";
                      t3.text = "";
                    },
                    child: Text(
                      "submit",
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 1, color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
