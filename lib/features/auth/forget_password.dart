import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakn/core/constants/check_email.dart';

class ForgetPassword extends StatefulWidget {
  final bool isFromUpdatePassword;

  const ForgetPassword({super.key, required this.isFromUpdatePassword});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool password = true;

  bool loading = false;

  FocusNode focusNode1 = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 50,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Forget Password",
                      style: TextStyle(fontSize: 30, fontFamily: 'Poppins'),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontFamily: 'Poppins'),
                      focusNode: focusNode1,
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter your email";
                        } else if (value.isValidEmail() == false) {
                          return "invalid email";
                        } else if (value.isValidEmail() == true) {
                          return null;
                        }
                        return null;
                      },
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Theme.of(context).shadowColor,
                          fontFamily: 'Poppins',
                        ),
                        errorStyle: const TextStyle(fontFamily: 'Poppins'),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: loading ? null : () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).primaryColorLight,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child:
                          loading == true
                              ? null
                              : const Text(
                                "Send email verification",
                                style: TextStyle(fontFamily: 'Poppins'),
                              ),
                    ),
                    widget.isFromUpdatePassword == true
                        ? SizedBox()
                        : TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Theme.of(context).splashColor,
                          ),
                          child:
                              loading == true
                                  ? Text("Loading")
                                  : const Text(
                                    "Back to Login",
                                    style: TextStyle(fontFamily: 'Poppins'),
                                  ),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//
