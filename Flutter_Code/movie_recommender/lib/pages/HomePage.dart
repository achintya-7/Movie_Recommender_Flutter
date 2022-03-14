// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_final_fields, unnecessary_new, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movie_recommender/models/DataModel.dart';
import 'package:movie_recommender/themes/themes.dart';
import 'package:movie_recommender/widgets/catalog_list.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _isLoading = -1;

  TextEditingController _searchController = new TextEditingController();

  makePostRequest(String queryText) async {
    setState(() {
      _isLoading = 1;
    });

    if (CatalogModel.items_list.isNotEmpty ||
        CatalogModel.items_list.length > 1) {
      CatalogModel.items_list.clear();
    }

    final uri = Uri.parse('http://192.168.1.9:12345/search');
    final headers = {'Content-Type': 'application/json'};
    var final_data = [];
    Map<String, dynamic> body = {
      "data": [
        {"text": queryText}
      ],
      "parameters": {"limit": 10}
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

    for (var itemJson in final_data) {
      CatalogModel.items_list.add(Item(
          Title: itemJson['tags']['Title'],
          Summary: itemJson['tags']['Short Summary'],
          Poster: itemJson['tags']['Movie Poster'],
          Rating: itemJson['tags']['Rating'].toString()));

      setState(() {
        _isLoading = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dummyList = List.generate(5, (index) => CatalogModel.Items[0]);

    return Scaffold(
      backgroundColor: Mytheme.darkcreamColor,
      appBar: AppBar(
        backgroundColor: Mytheme.darkBluishColor,
        centerTitle: true,
        title: "Movie Recommendor".text.make(),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 100,
              width: 400,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 18,
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
                            fillColor: Mytheme.darkBluishColor,
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
                    backgroundColor: Mytheme.darkBluishColor,
                    child: IconButton(
                        onPressed: () {
                          makePostRequest(_searchController.text);
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        icon: Icon(
                          Icons.search,
                          size: 28,
                          color: Colors.white,
                        )),
                  ).pOnly(right: 8, left: 8, bottom: 4)
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
                  height: 44,
                  child: CatalogModel.items_list.isNotEmpty
                      ? ListView.builder(
                          itemCount: CatalogModel.items_list.length,
                          itemBuilder: (context, index) {
                            return CatalogItem(
                                catalog: CatalogModel.items_list[index]);
                          }).p(8)
                      : _isLoading == 1
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox()))
        ],
      ),
    );
  }
}
