import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String email;

  const VerifyScreen({super.key, required this.email});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool loading = false;

  void navigate() {
    setState(() {
      loading = true;
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    }).whenComplete(() {
      Get.offAll(() => const LoginScreen(), transition: Transition.fadeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            spacing: 50,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Verify your email",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 25),
              ),
              Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Confirmation mail has been sent to",
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed:
                    loading
                        ? null
                        : () {
                          navigate();
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Theme.of(context).primaryColorLight,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: const Text(
                  "Login now",
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
