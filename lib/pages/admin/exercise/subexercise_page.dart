import 'package:flutter/material.dart';

class SubExercisePage extends StatefulWidget {
  const SubExercisePage({Key? key}) : super(key: key);

  @override
  State<SubExercisePage> createState() => _SubExercisePageState();
}

class _SubExercisePageState extends State<SubExercisePage> {
  String? _selectedLevel;
  int _correctOptionIndex = 0;
  TextEditingController _questionController = TextEditingController();
  List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool _fieldsFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/appbar-exercise.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(blurRadius: 30.0),
            ],
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(
                MediaQuery.of(context).size.width,
                100.0,
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'WRITING',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Level",
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          menuMaxHeight: 200,
                          underline: null,
                          isExpanded: true,
                          value: _selectedLevel,
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Choose level",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          items: <String>['Level 1', 'Level 2', 'Level 3']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(value),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedLevel = newValue;
                            });
                          },
                          icon: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Question 1",
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _questionController,
                            decoration: InputDecoration(
                              hintText: 'Type your question here',
                              hintStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 10.0,
                              ),
                            ),
                          ),
                          for (int i = 0; i < 4; i++)
                            _buildOptionInput('Option ${i + 1}', _optionControllers[i]),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Correct Answer :',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                const SizedBox(width: 10),
                                DropdownButton<int>(
                                  value: _correctOptionIndex,
                                  onChanged: (int? newValue) {
                                    setState(() {
                                      _correctOptionIndex = newValue!;
                                    });
                                  },
                                  items: List.generate(4, (index) => index)
                                      .map<DropdownMenuItem<int>>(
                                        (int value) => DropdownMenuItem<int>(
                                          value: value,
                                          child: Text('Option ${value + 1}'),
                                        ),
                                      )
                                      .toList(),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            // Check if all required fields are filled
            if (_selectedLevel != null &&
                _questionController.text.isNotEmpty &&
                _optionControllers.every((controller) => controller.text.isNotEmpty)) {
              // If all fields are filled, show the notification
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('The new question is saved successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D0443),
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          ),
          child: Text(
            'Save',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
