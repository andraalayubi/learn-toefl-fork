import 'package:flutter/material.dart';
import 'package:learn_toefl/models/article_model.dart';
import 'package:learn_toefl/pages/user/pages/single_article_page.dart';
import 'package:learn_toefl/utilities.dart';

class ArticleCard extends StatefulWidget {
  const ArticleCard({required this.data, super.key});
  final ArticleData data;

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleArticlePage(data: widget.data)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   width: 1,
          //   color: Colors.black,
          // ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 197, 196, 196),
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 159.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: 159.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(widget.data.urlToImage!),
                        fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          widget.data.title!,
                          style: tFOnt(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          widget.data.source!,
                          style: tFOnt(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
