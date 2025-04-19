import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sakn/core/constants/check_email.dart';
import 'package:sakn/core/widgets/show_flushbar.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool password = true;
  bool loading = false;
  bool agreeToTermsAndConditions = false;

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future signUp() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        await FirebaseAuth.instance.currentUser!.sendEmailVerification();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
              'name': nameController.text,
              'email': emailController.text,
              'password': passwordController.text,
              'uid': FirebaseAuth.instance.currentUser!.uid,
              'role': 'user',
              'signUpDate': DateFormat('d,MMMM,yyyy').format(DateTime.now()),
            });

        setState(() {
          loading = false;
        });

        showSuccess('Successfully Registered', context);
      } catch (error) {
        setState(() {
          loading = false;
        });
        showError(error.toString(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 40, fontFamily: 'Poppins'),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    cursorColor: Theme.of(context).secondaryHeaderColor,
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "you must enter your name";
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.username],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "username",
                      errorStyle: const TextStyle(fontFamily: 'Poppins'),
                      hintStyle: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontFamily: 'Poppins',
                      ),
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    cursorColor: Theme.of(context).secondaryHeaderColor,
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
                    autofillHints: const [
                      AutofillHints.email,
                      AutofillHints.password,
                    ],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "email",
                      errorStyle: const TextStyle(fontFamily: 'Poppins'),
                      hintStyle: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontFamily: 'Poppins',
                      ),
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
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(fontFamily: 'Poppins'),
                    cursorColor: Theme.of(context).secondaryHeaderColor,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "you must enter password";
                      }
                      if (value.contains("-")) {
                        return "can't include -";
                      }
                      if (value.length < 5) {
                        return "weak password";
                      }
                      return null;
                    },
                    autofillHints: const [AutofillHints.password],
                    obscureText: password,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            password = !password;
                          });
                        },
                        icon: Icon(
                          password ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                      hintText: "password",
                      errorStyle: const TextStyle(fontFamily: 'Poppins'),
                      hintStyle: TextStyle(
                        color: Theme.of(context).shadowColor,
                        fontFamily: 'Poppins',
                      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        checkColor: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        activeColor: Theme.of(context).primaryColor,
                        hoverColor: Colors.transparent,
                        value: agreeToTermsAndConditions,
                        onChanged: (value) {
                          setState(() {
                            agreeToTermsAndConditions =
                                !agreeToTermsAndConditions;
                          });
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Theme.of(context).indicatorColor,
                              ),
                            ),
                            TextSpan(
                              text: "Terms and conditions",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.blue.shade900,
                              ),
                              recognizer:
                                  TapGestureRecognizer()..onTap = () async {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed:
                        loading
                            ? null
                            : () {
                              signUp();
                            },
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
                            ? LoadingAnimationWidget.progressiveDots(
                              color: Colors.black,
                              size: 20,
                            )
                            : const Text(
                              "Sign up",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account ?  ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.blue.shade900,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () async {
                                  Get.offAll(
                                    LoginScreen(),
                                    transition: Transition.fadeIn,
                                    duration: Duration(milliseconds: 400),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    child: Row(
                      spacing: 20,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).shadowColor,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                            color: Theme.of(context).shadowColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Theme.of(context).shadowColor,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 50),
                      //iconColor: Colors.transparent,
                      foregroundColor: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 15,
                      children: [
                        const Image(
                          image: AssetImage("assets/login/google_2.png"),
                          height: 20,
                        ),
                        const Text(
                          "Continue with Google",
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Sql - Table - Colums - Rows - data

// Firestore - Collection - documents - Field

// Email - Password - Create new user
