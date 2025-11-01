import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/screens/login_screen.dart';

import '../model/user_model.dart';

class HomeScreen extends StatelessWidget {
  UserModel userModel;

   HomeScreen({
    required this.userModel

  }) ;

  @override
  Widget build(BuildContext context) {final user=userModel.user;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Title ---
              Text(
                'WELCOME, ${user?.name??""} 👋',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Here’s your profile info:',
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.04,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 40),

              // --- Info Card ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('🆔 ID', user?.id.toString()??""),
                    const SizedBox(height: 15),
                    _infoRow('👤 Name', user?.name??""),
                    const SizedBox(height: 15),
                    _infoRow('📱 Phone', user?.mobile??""),
                  ],
                ),
              ),
              const Spacer(),

              // --- Logout Button ---
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                      );
                    });
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7F75B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  child: Text(
                    'Logout',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper widget for info rows ---
  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(color: Colors.grey.shade400, fontSize: 16),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
