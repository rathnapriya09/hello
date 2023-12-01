import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:postmethod/model/second.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: firstscreen(),
    );
  }
}

class firstscreen extends StatefulWidget {
  const firstscreen({super.key});

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  Future<List> post() async {
    var stringurl = 'https://kuwycredit.in/servlet/rest/ltv/forecast/ltvMakes';

    var uri = Uri.parse(stringurl);

    var parameters = {"year": "2020"};

    var encode = jsonEncode(parameters);

    var context = {"Content-Type": "application/json"};

    var package = await http.post(uri, body: encode, headers: context);

    Map data = jsonDecode(package.body);

    List alldata = data["makeList"];

    return alldata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('P o s t  M e t h o d'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: post(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List changedata = snapshot.data;
                return ListView.builder(
                    itemCount: changedata.length,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => hello(
                                        name: changedata[index].toString())));
                          },
                          child: Text(changedata[index].toString()));
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }
            }));
  }
}
