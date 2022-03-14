// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_recommender/models/DataModel.dart';
import 'package:movie_recommender/themes/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Row(
        children: [
          Image.network(
            catalog.Poster
          ).box.rounded.p8.color(Mytheme.darkcreamColor).make().p(16).w32(context),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              catalog.Title.text.lg.color(context.accentColor).bold.make(),
              catalog.Summary.text.color(Colors.white30).make(),
              
            ],
          )
          )
        ],
      ).badge(
        color: Mytheme.darkcreamColor,
        type: VxBadgeType.round,
        optionalWidget: catalog.Rating.text.make(),
        size: 28
      )
    ).color(Mytheme.darkBluishColor).rounded.square(150).make().py16();
  }
}
