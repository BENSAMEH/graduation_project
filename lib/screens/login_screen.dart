import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    // ✅ نحسب حجم الشاشة
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.09,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.08),

              // --- Title ---
              Text(
                'WELCOME BACK!',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.08, // responsive font size
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Enter your details below',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.04,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: height * 0.04),

              // --- Phone Number Field ---
              IntlPhoneField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Mobile Number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                dropdownTextStyle: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                initialCountryCode: 'EG',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(height: height * 0.025),

              // --- Password Field ---
              Container(
                height: height * 0.065,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: TextField(
                    obscureText: _obscurePassword,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.015),

              // --- Forget Password ---
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forget password?',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: width * 0.035,
                  ),
                ),
              ),
              SizedBox(height: height * 0.04),

              // --- Log In Button ---
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7F75B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  child: Text(
                    'Log In',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // --- Sign Up ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  Text(
                    "Sign Up",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFFD7F75B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),

              // --- Skip ---
              Center(
                child: Text(
                  'Skip for now',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade400,
                    fontSize: width * 0.035,
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
