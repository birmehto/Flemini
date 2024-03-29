import 'package:flemini/cloud_sevices/authantication.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NewPass extends StatefulWidget {
  const NewPass({super.key});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: LottieBuilder.asset('assets/animation/resset.json'),
          ),
          Text(
            'Reset Password',
            style:
                GoogleFonts.adamina(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              forgotpass(email.text);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(156, 114, 224, 1),
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
