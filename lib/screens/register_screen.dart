import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Api/api_provider.dart';
import 'package:graduation_project/screens/login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

              // --- Title ---
              Text(
                'REGISTER!',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: height * 0.01),
              Text(
                'Join Us Now',
                style: GoogleFonts.poppins(
                  fontSize: width * 0.04,
                  color: Colors.grey.shade400,
                ),
              ),
              SizedBox(height: height * 0.04),

              // --- Name Field ---
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: TextField(
                  controller: nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
              SizedBox(height: height * 0.025),

              // --- Phone Field ---
              IntlPhoneField(
                controller: phoneController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintText: 'Mobile Number',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
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
              SizedBox(height: height * 0.02),

              // --- Password Field ---
              Container(
                height: height * 0.065,
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
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
              SizedBox(height: height * 0.04),

              // --- Register Button ---
              SizedBox(
                width: double.infinity,
                height: height * 0.065,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text.trim();
                    final phone = phoneController.text.trim();
                    final password = passwordController.text.trim();

                    if (name.isEmpty || phone.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    final response = await ApiProvider().register(
                      name: name,
                      phoneNumber: phone,
                      password: password,
                    );

                    if (response != null && response.statusCode == 201) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("✅ Registered successfully")),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "❌ Failed: ${response?.data ?? 'Unknown error'}",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD7F75B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.05),
                    ),
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),

              // --- Sign In Text ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account? ",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFD7F75B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
