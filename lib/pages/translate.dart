import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TransletePageState();
}

class _TransletePageState extends State<TranslatePage> {
  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text(
          'TRANSLATOR',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0D0443),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFF0D0443),
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(),
                height: height * 0.03,
                width: width,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                height: height * 0.97,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 360,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFF0D0443),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Understand comfortably in your own language.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              'assets/images/proud.png',
                              width: 85,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26.0),
                      height: 60,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Center(
                                child: DropdownButton(
                                  hint: Text(
                                    'English',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D0443),
                                    ),
                                  ),
                                  items: [],
                                  onChanged: (value) {},
                                  underline: Container(),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.swap_horiz),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Center(
                                child: DropdownButton(
                                  hint: Text(
                                    'Indonesian',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0D0443),
                                    ),
                                  ),
                                  items: [],
                                  onChanged: (value) {},
                                  underline: Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 26.0),
                              child: Text('Translete From'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26.0),
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter text here...',
                                  border: InputBorder.none,
                                ),
                                maxLines: 10,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'English',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text('Translete To'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 26.0),
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter text here...',
                                  border: InputBorder.none,
                                ),
                                maxLines: 10,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Indonesian',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.content_copy),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
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
  }
}
