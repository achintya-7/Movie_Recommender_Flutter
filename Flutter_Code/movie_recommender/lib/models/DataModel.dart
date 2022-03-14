// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class CatalogModel {
  static final Items = [
    Item(
      Title: "12 Action",
      Summary:
          "Special Forces team deployed to Afghanistan after 9/11; under the leadership of a new captain, the team must work with an Afghan warlord to take down the Taliban.",
      Rating: 6.7.toString(),
      Poster:
          "https://m.media-amazon.com/images/M/MV5BNTEzMjk3NzkxMV5BMl5BanBnXkFtZTgwNjY2NDczNDM@._V1_.jpg",
    )
  ];

  static final List<Item> items_list = [];
}

class Item {
  String Title;
  String Summary;
  String Poster;
  String Rating;
  Item({
    required this.Title,
    required this.Summary,
    required this.Poster,
    required this.Rating,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'Title': Title,
      'Short Summary': Summary,
      'Movie Poster': Poster,
      'Rating': Rating,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      Title: map['Title'] ?? '',
      Summary: map['Short Summary'] ?? '',
      Poster: map['Movie Poster'] ?? '',
      Rating: map['Rating'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));
}
