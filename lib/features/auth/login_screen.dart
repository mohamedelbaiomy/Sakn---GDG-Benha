import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sakn/core/constants/check_email.dart';
import 'package:sakn/features/auth/signup_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;
  bool loading = false;
  bool docExists = false;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  clearFocusNode() {
    focusNode1.unfocus();
    focusNode2.unfocus();
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        clearFocusNode();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              spacing: 2,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Text(
                      "EN",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "AR",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 250,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Poppins',
                            color: Theme.of(context).splashColor,
                          ),
                        ),
                        Text(
                          "Welcome Back, please enter your details",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontFamily: 'Poppins'),
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      focusNode: focusNode1,
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
                      controller: emailController,
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
                      focusNode: focusNode2,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "you must enter your password";
                        }
                        return null;
                      },
                      autofillHints: [AutofillHints.password],
                      controller: passwordController,
                      obscureText: password,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
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
                        hintStyle: TextStyle(
                          color: Theme.of(context).shadowColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.to(
                            () => ForgetPassword(isFromUpdatePassword: false),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).indicatorColor,
                        ),
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(fontFamily: 'Poppins'),
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
                                "Login",
                                style: TextStyle(fontFamily: 'Poppins'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ?",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Theme.of(context).indicatorColor,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              () => const SignupScreen(),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 300),
                            );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue.shade900,
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
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
