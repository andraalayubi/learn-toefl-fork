import 'package:flutter/material.dart';
import 'package:learn_toefl/models/article_model.dart';
import 'package:learn_toefl/pages/user/pages/single_article_item_header_delegate.dart';
import 'package:learn_toefl/utilities.dart';

class SingleArticlePage extends StatefulWidget {
  const SingleArticlePage({required this.data, super.key});
  final ArticleData data;

  @override
  State<SingleArticlePage> createState() => _SingleArticlePageState();
}

class _SingleArticlePageState extends State<SingleArticlePage> {
  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final maxScreenSizeHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mColor,
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const MyApp(),
      //         ),
      //       );
      //     },
      //     child: const SafeArea(
      //       child: Padding(
      //         padding: EdgeInsets.only(left: 10.0),
      //         child: Icon(
      //           CupertinoIcons.back,
      //           size: 30,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SingleArticlesItemHeaderDelegate(
                data: widget.data,
                minExtent: topPadding + 56,
                maxExtent: maxScreenSizeHeight / 2),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.content!,
                    style: tFOnt(fontSize: 15),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
