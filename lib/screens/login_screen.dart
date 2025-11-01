import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/model/user_model.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../Api/api_provider.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
   UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: height * 0.12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),

              // Title
              Text(
                'WELCOME BACK!',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.08,
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
                controller: phoneController,
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
                    controller: passwordController,
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
                  onPressed: _isLoading
                      ? null
                      : () async {
                    final phone = phoneController.text.trim();
                    final password = passwordController.text.trim();

                    if (phone.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all fields"),
                        ),
                      );
                      return;
                    }

                    setState(() => _isLoading = true);

                    try {
                      final userModel =
                      await ApiProvider().login(phone, password);

                      if (userModel != null) {
                        final user = userModel.user;

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                              Text("✅ Login successful!")),
                        );

                        print('User data: ${userModel.user}');

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                             userModel: userModel,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "❌ Login failed. Please check your credentials."),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("⚠️ Error: $e")),
                      );
                    } finally {
                      setState(() => _isLoading = false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7F75B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : Text(
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

              // --- Register Link ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD7F75B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),




            ],
          ),
        ),
      ),
    );
  }
}
