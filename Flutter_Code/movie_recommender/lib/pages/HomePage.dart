// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_final_fields, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_recommender/themes/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = new TextEditingController();

  makePostRequest(String queryText) async {
    final uri = Uri.parse('http://localhost:2205/search');
    final headers = {'Content-Type': 'application/json'};
    var final_data = [];
    Map<String, dynamic> body = {
      "data": [
        {"text": queryText}
      ],
      "parameters": {"limit": 5}
    };
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: jsonBody,
      encoding: encoding,
    );

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print(statusCode);
    var convertedData = jsonDecode(responseBody);
    final_data = convertedData['data'][0]['matches'];

    for (var item in final_data) {
      print(item['tags']['title']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mytheme.darkBluishColor,
      appBar: AppBar(
        backgroundColor: Mytheme.darkcreamColor,
        centerTitle: true,
        title: "Movie Recommendor".text.make(),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                width: 400,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: 
                          [
                             SizedBox(
                              height: 20,
                            ),

                            TextFormField(
                            controller: _searchController,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: "Search Term",
                              hintStyle: TextStyle(color: Colors.white70),
                              fillColor: Mytheme.darkcreamColor,
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (title) => title != null && title.isEmpty
                                ? 'Cannot be empty'
                                : null,
                          ).pOnly(left: 8, top: 8),
                        ],
                      ),
                    ),
                    
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Mytheme.darkcreamColor,
                      child: IconButton(
                        onPressed: () {


                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        icon: Icon(Icons.search, size: 26,)),
                    ).pOnly(right: 8, left: 8)
                  ],
                ),
                
              ),
            ),
          )
        ],
      ),
    );
  }
}
