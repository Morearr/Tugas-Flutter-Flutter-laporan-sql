import 'package:flutter/material.dart';
import 'tamus_view.dart'; // Pastikan import sudah benar ke file TamusView

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                size: 100,
                color: Colors.red[800], // Matching icon color with AppBar color
              ),
              SizedBox(height: 20),
              Text(
                'HALLO!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for contrast
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Klik tombol login untuk masuk ke daftar tamu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      Colors.grey[400], // Lighter grey text for better contrast
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman daftar tamu
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TamusView()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red[800], // Match button with AppBar color
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white, // White text on the button
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
