import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:learn_toefl/utilities.dart';
import 'package:translator/translator.dart';

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TransletePageState();
}

class _TransletePageState extends State<TranslatePage> {
  List<String> languages = [
    'English',
    'Indonesian',
  ];
  List<String> languagesCode = ['en', 'id'];

  final translator = GoogleTranslator();
  String from = 'en';
  String to = 'id';
  String data = '';
  String selectedValue1 = 'English';
  String selectedValue2 = 'Indonesian';
  TextEditingController controller = TextEditingController(text: '');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> translate() async {
    try {
      if (formKey.currentState != null &&
          formKey.currentState!.validate() &&
          controller.text.isNotEmpty) {
        await translator
            .translate(controller.text, from: from, to: to)
            .then((value) {
          setState(() {
            data = value.text;
          });
          print(value);
        });
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No Internet'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ),
      );
      setState(() {});
    }
  }

  void translateOnChange() {
    translate();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(translateOnChange);

    translate();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _copy(String textToCopy) {
      final nilai = ClipboardData(text: textToCopy);
      Clipboard.setData(nilai);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Text copied to clipboard'),
          duration:
              Duration(seconds: 2), // Sesuaikan durasinya sesuai kebutuhan
        ),
      );
    }

    _paste() async {
      final data = await Clipboard.getData(Clipboard.kTextPlain);
      if (data != null) {
        controller.text = data.text ?? '';
      }
    }

    final screenHeight = MediaQuery.of(context).size.height;
    final containerWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0D0443),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          'TRANSLATOR',
          style: tFOnt(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D0443),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          constraints: BoxConstraints(minHeight: screenHeight),
          width: containerWidth,
          child: Column(
            children: [
              // Container(
              //   decoration: const BoxDecoration(),
              //   height: height * 0.03,
              //   width: width,
              // ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                // height: height * 0.97,
                width: containerWidth,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              mColor,
                              mColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.4, 1],
                          ),
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
                                    style: tFOnt(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                            Image.asset(
                              'assets/images/proud.png',
                              width: 85,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26.0),
                      height: 60,
                      width: containerWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Center(
                                child: DropdownButton(
                                  value: selectedValue1,
                                  hint: Text(
                                    'English',
                                    style: tFOnt(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF0D0443),
                                    ),
                                  ),
                                  items: languages.map((lang) {
                                    return DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang),
                                      onTap: () {
                                        if (lang == languages[0]) {
                                          from = languagesCode[0];
                                        } else if (lang == languages[1]) {
                                          from = languagesCode[1];
                                        } else if (lang == languages[2]) {
                                          from = languagesCode[2];
                                        } else if (lang == languages[3]) {
                                          from = languagesCode[3];
                                        } else if (lang == languages[4]) {
                                          from = languagesCode[4];
                                        } else if (lang == languages[5]) {
                                          from = languagesCode[5];
                                        } else if (lang == languages[6]) {
                                          from = languagesCode[6];
                                        }
                                        setState(() {
                                          print(lang);
                                          print(from);
                                          from = languagesCode[
                                              languages.indexOf(lang)];
                                          print('From : $from');
                                          translate();
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedValue1 = value!;
                                    setState(() {
                                      from = languagesCode[
                                          languages.indexOf(value)];
                                      translate();
                                    });
                                  },
                                  underline: Container(),
                                ),
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   child: Icon(Icons.swap_horiz),
                          //   onTap: () {
                          //     print('Pembalik');
                          //   },
                          // ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Center(
                                child: DropdownButton(
                                  value: selectedValue2,
                                  hint: Text(
                                    'Indonesian',
                                    style: tFOnt(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: mColor,
                                    ),
                                  ),
                                  items: languages.map((lang) {
                                    return DropdownMenuItem(
                                      value: lang,
                                      child: Text(lang),
                                      onTap: () {
                                        if (lang == languages[0]) {
                                          to = languagesCode[0];
                                        } else if (lang == languages[1]) {
                                          to = languagesCode[1];
                                        } else if (lang == languages[2]) {
                                          to = languagesCode[2];
                                        } else if (lang == languages[3]) {
                                          to = languagesCode[3];
                                        } else if (lang == languages[4]) {
                                          to = languagesCode[4];
                                        } else if (lang == languages[5]) {
                                          to = languagesCode[5];
                                        } else if (lang == languages[6]) {
                                          to = languagesCode[6];
                                        }
                                        setState(() {
                                          print(lang);
                                          print(from);
                                          selectedValue2 = lang;
                                          to = languagesCode[
                                              languages.indexOf(lang)];
                                          print('to : $to');
                                          translate();
                                        });
                                      },
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedValue2 = value!;
                                    setState(() {
                                      to = languagesCode[
                                          languages.indexOf(value)];
                                      translate();
                                    });
                                  },
                                  underline: Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                              child: Text(
                                'Translate From',
                                style: tFOnt(fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26.0),
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Form(
                                key: formKey,
                                child: TextFormField(
                                  controller: controller,
                                  maxLines: null,
                                  minLines: null,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      hintText: 'Enter text here...',
                                      hintStyle: tFOnt(),
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      errorBorder: InputBorder.none),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
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
                                  selectedValue1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              InkWell(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _copy(controller
                                            .text); // Salin dari translate from
                                      },
                                      icon: const Icon(Icons.content_copy),
                                    ),
                                    IconButton(
                                        onPressed: _paste,
                                        icon: const Icon(Icons.content_paste))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text(
                            'Translate To',
                            style: tFOnt(fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 26.0),
                      height: 240,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1.0, color: Colors.black),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: SelectableText(
                                data,
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
                                  selectedValue2,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _copy(data); // Salin dari translate to
                                },
                                child: const IconButton(
                                    icon: Icon(
                                      Icons.content_copy,
                                      color: Colors.black,
                                    ),
                                    onPressed: null),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: translate,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color(0xFF0D0443),
                  ),
                ),
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        'Translate',
                        style: tFOnt(color: Colors.white),
                      ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
