import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:learn_toefl/main.dart';
import 'package:learn_toefl/models/article_model.dart';
import 'package:learn_toefl/utilities.dart';

class SingleArticlesItemHeaderDelegate extends SliverPersistentHeaderDelegate {
  final ArticleData data;
  @override
  final double maxExtent;
  @override
  final double minExtent;

  const SingleArticlesItemHeaderDelegate({
    required this.data,
    required this.maxExtent,
    required this.minExtent,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: NetworkImage(data.urlToImage!),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 50,
          left: 25,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
            child: const Icon(
              CupertinoIcons.back,
              size: 35,
              color: Colors.grey,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 25.0, right: 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  mColor,
                  Colors.transparent,
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title!,
                      style: tFOnt(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.source!,
                      style: tFOnt(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();
}
