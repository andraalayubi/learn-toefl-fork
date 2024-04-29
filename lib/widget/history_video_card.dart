import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';

class HistoryVideoCard extends StatefulWidget {
  const HistoryVideoCard({super.key});

  @override
  State<HistoryVideoCard> createState() => _HistoryVideoCardState();
}

class _HistoryVideoCardState extends State<HistoryVideoCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/images/video.png', // Ganti dengan path gambar Anda
                      width: 159.2,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 174, 148),
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              'Grammar',
                              style: tFOnt(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            'Listening 1  - 100 idiom',
                            style: tFOnt(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
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
        );
      }),
    );
  }
}
