// UNCOMMENT tapi gurung kesambung soko exercise 

// import 'package:flutter/material.dart';
// import 'package:learn_toefl/models/question.dart';
// import 'package:learn_toefl/pages/user/exercise/summary.dart';
// import 'package:learn_toefl/widget/question_widgets.dart';

// class WritingTest extends StatefulWidget {
//   final int questionGroupId;
//   const WritingTest({Key? key, required this.questionGroupId})
//       : super(key: key);

//   @override
//   _WritingTestState createState() => _WritingTestState();
// }

// class _WritingTestState extends State<WritingTest> {
//   late Future<QuestionDetail> _futureQuestionDetail;
//   String? userResponse;

//   @override
//   void initState() {
//     super.initState();
//     _futureQuestionDetail = fetchPracticeDetail(widget.questionGroupId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(100),
//         child: ClipPath(
//           clipper: CustomAppBar(),
//           child: AppBar(
//             title: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Correct or Incorrect?',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             backgroundColor: const Color(0xFF0D0443),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: FutureBuilder<QuestionDetail>(
//               future: _futureQuestionDetail,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 } else {
//                   final detail = snapshot.data!;

//                   return SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         if (detail.readingText.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.symmetric(vertical: 8.0),
//                             child: Container(
//                               width: double.infinity,
//                               child: CustomBox(
//                                 title: 'Instruction',
//                                 content: detail.readingText,
//                               ),
//                             ),
//                           ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: Container(
//                             width: double.infinity,
//                             child: ResponseBox(
//                               questionNumber: 1,
//                               onSelect: (response) {
//                                 setState(() {
//                                   userResponse = response;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0),
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 // Logika untuk menilai jawaban dan navigasi ke halaman hasil
//                                 final correct = userResponse ==
//                                     "expected answer"; // Ganti dengan logika yang sesuai
//                                 final incorrect = !correct;

//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => Summary(
//                                       score: correct ? 1 : 0,
//                                       correct: correct ? 1 : 0,
//                                       incorrect: incorrect ? 1 : 0,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF0D0443),
//                               ),
//                               child: const Text(
//                                 'Submit',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CustomAppBar extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//         size.width / 4, size.height - 40, size.width / 2, size.height - 20);
//     path.quadraticBezierTo(
//         3 / 4 * size.width, size.height, size.width, size.height - 20);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class ResponseBox extends StatelessWidget {
//   final int questionNumber;
//   final ValueChanged<String> onSelect;

//   const ResponseBox({
//     required this.questionNumber,
//     required this.onSelect,
//   });

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController _controller = TextEditingController();
//     return Card(
//       elevation: 4,
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Your Response $questionNumber:',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Type Your Answer',
//               ),
//               onChanged: (value) {
//                 onSelect(value);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
