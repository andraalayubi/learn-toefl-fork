import 'package:flutter/material.dart';

// CustomClipper untuk setengah lingkaran terbalik
class InvertedHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final centerX = size.width / 2;
    final radius = size.width / 2;

    // Membuat setengah lingkaran terbalik yang mencapai setengah layar
    path.moveTo(0, 0); // Mulai dari atas
    path.quadraticBezierTo(centerX, radius, size.width, 0); // Setengah lingkaran
    path.lineTo(size.width, size.height); // Lanjutkan ke bawah
    path.lineTo(0, size.height); // Tutup bagian bawah

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false; // Tidak perlu reclip
  }
}


class Summary extends StatefulWidget {
  final int score;
  final int correct;
  final int incorrect;

  Summary({
    required this.score,
    required this.correct,
    required this.incorrect,
  });

  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF0D0443),
      ),
      body: Stack(
        children: [
          // ClipPath dengan setengah lingkaran terbalik
          ClipPath(
            clipper: InvertedHalfCircleClipper(),
            child: Container(
              color: Color(0xFF0D0443),
              height: 400, // Tinggi untuk setengah lingkaran terbalik
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20), // Padding untuk tata letak
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50), // Jarak agar konten tidak terlalu dekat
                Text(
                  'Congratulations!\nYou have completed all questions.',
                  textAlign: TextAlign.center, // Rata tengah
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your score is:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow:[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.score}', 
                        style: TextStyle(
                          fontSize: 60, 
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 20), 
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green[100], 
                            borderRadius: BorderRadius.circular(16),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '${widget.correct} Correct',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                        SizedBox(height: 10), 
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red[100], 
                            borderRadius: BorderRadius.circular(16),
                            boxShadow:[
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '${widget.incorrect} Incorrect',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700], 
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Go Back to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
