import 'package:flemini/cloud_sevices/authantication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();

  bool isLoading = false;

  Future<void> _signup() async {
    setState(() {
      isLoading = true;
    });

    // Call your sign-up function passing email and password
    await signup(emailController.text.trim(), passwordController.text.trim());

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return _buildWideLayout();
        },
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: buildAssetImage(),
        ),
        Expanded(
          flex: 1,
          child: _buildSignupForm(),
        ),
      ],
    );
  }

  Widget buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildAssetImage(),
          _buildSignupForm(),
        ],
      ),
    );
  }

  Widget buildAssetImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            width: 350,
            child: LottieBuilder.asset('assets/animation/signup.json'),
          ),
          Text(
            'Register Now',
            style: GoogleFonts.adamina(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Create an account to continue',
            style: GoogleFonts.adamina(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sign Up',
            style: GoogleFonts.adamina(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(height: 15),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
          ),
          const SizedBox(height: 15),
          TextFormField(
            obscureText: true,
            controller: cpasswordController,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onEditingComplete: () => FocusScope.of(context).unfocus(),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              String password = passwordController.text.trim();
              String cpassword = cpasswordController.text.trim();

              if (password == cpassword) {
                _signup();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Passwords do not match'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(156, 114, 224, 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const DLoginPage());
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
