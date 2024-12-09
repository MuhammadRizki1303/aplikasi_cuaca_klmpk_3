import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int _selectedRating = 0; // Menyimpan nilai penilaian pengguna

  String getFeedbackText() {
    if (_selectedRating == 1) return 'Tidak Puas';
    if (_selectedRating == 2) return 'Kurang Puas';
    if (_selectedRating == 3) return 'Cukup Puas';
    if (_selectedRating == 4) return 'Puas';
    if (_selectedRating == 5) return 'Sangat Puas';
    return '';
  }

  IconData getFeedbackIcon() {
    if (_selectedRating == 1) return Icons.sentiment_very_dissatisfied;
    if (_selectedRating == 2) return Icons.sentiment_dissatisfied;
    if (_selectedRating == 3) return Icons.sentiment_neutral;
    if (_selectedRating == 4) return Icons.sentiment_satisfied;
    if (_selectedRating == 5) return Icons.sentiment_very_satisfied;
    return Icons.sentiment_satisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penilaian Aplikasi'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400.withOpacity(0.8),
              Colors.orangeAccent.shade200.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          // Membungkus konten agar bisa di-scroll
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: kToolbarHeight + 20.0),
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: const Color.fromARGB(255, 255, 242, 3),
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Beri Penilaian',
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Kami sangat menghargai masukan dan penilaian Anda untuk membantu kami meningkatkan aplikasi ini.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRating = index + 1;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: 40.0,
                        color: index < _selectedRating
                            ? const Color.fromARGB(255, 255, 242, 3)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20.0),
                if (_selectedRating > 0) ...[
                  Column(
                    children: [
                      Icon(
                        getFeedbackIcon(),
                        color: Colors.blue.shade900,
                        size: 80.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        getFeedbackText(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedRating == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Silakan pilih jumlah bintang terlebih dahulu.'),
                          backgroundColor:
                              const Color.fromARGB(255, 255, 17, 0),
                        ),
                      );
                    } else {
                      _showConfirmationDialog(context);
                    }
                  },
                  child: Text(
                    'Kirim Penilaian',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Terima kasih atas masukan Anda!',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: const Color.fromARGB(255, 87, 84, 84),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Penilaian'),
          content: Text(
            'Anda memberikan penilaian $_selectedRating bintang. Apakah Anda yakin?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Terima kasih atas penilaian Anda!'),
                    backgroundColor: Colors.green,
                  ),
                );
                setState(() {
                  _selectedRating = 0;
                });
              },
              child: Text('Kirim'),
            ),
          ],
        );
      },
    );
  }
}
