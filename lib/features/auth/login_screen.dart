import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:restart_app/restart_app.dart';
import 'package:sakn/core/constants/check_email.dart';
import 'package:sakn/core/widgets/show_flushbar.dart';
import 'package:sakn/features/auth/repo/auth_repo.dart';
import 'package:sakn/features/auth/signup_screen.dart';
import 'package:sakn/features/buttom_navigation_bar/buttom_vav_bar.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool password = true;
  bool loading = false;
  bool resendEmailVerification = false;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  clearFocusNode() {
    focusNode1.unfocus();
    focusNode2.unfocus();
  }

  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        await AuthRepo.singInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (await AuthRepo.checkEmailVerified()) {
          setState(() {
            loading = false;
          });
          // page3
          Get.offAll(const ButtomVavBar());
        } else {
          setState(() {
            loading = false;
            resendEmailVerification = true;
          });
          if (context.mounted) showError('please verify your email', context);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        if (e.code == 'wrong-password') {
          showError('password is incorrect', context);
        } else if (e.code == 'user-not-found') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'invalid-credential') {
          showError('password or email is incorrect', context);
        } else if (e.code == 'network-request-failed') {
          showError('check you connection and try again', context);
        } else {
          showError(e.code, context);
        }
      } catch (e) {
        setState(() {
          loading = false;
        });
        if (context.mounted) showError(e.toString(), context);
      } finally {
        setState(() {
          loading = false;
        });
      }
    }
  }

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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              spacing: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    context.setLocale(const Locale('en'));
                    Restart.restartApp();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(color: Colors.black),
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
                  onTap: () {
                    context.setLocale(const Locale('ar'));
                    Restart.restartApp();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(color: Colors.black),
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
                        ).tr(),
                        Text(
                          "Welcome Back, please enter your details",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            color: Theme.of(context).shadowColor,
                          ),
                        ).tr(),
                      ],
                    ),
                    resendEmailVerification == false
                        ? const Text("")
                        : ElevatedButton(
                          onPressed: () async {
                            try {
                              await AuthRepo.sendEmailVerification();
                              setState(() {
                                resendEmailVerification = false;
                              });
                              showSuccess("email verification sent", context);
                            } catch (e) {
                              showError(e.toString(), context);
                            }
                          },
                          child: const Text("Resend email verification"),
                        ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(fontFamily: 'Poppins'),
                      cursorColor: Theme.of(context).secondaryHeaderColor,
                      focusNode: focusNode1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return context.tr("please enter your email");
                        } else if (value.isValidEmail() == false) {
                          return context.tr("invalid email");
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
                        hintText: context.tr("email"),
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
                            () => const ForgetPassword(
                              isFromUpdatePassword: false,
                            ),
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
                      onPressed:
                          loading
                              ? null
                              : () {
                                login();
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).primaryColorLight,
                        minimumSize: const Size(double.infinity, 50),
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
                        minimumSize: const Size(double.infinity, 50),
                        //iconColor: Colors.transparent,
                        foregroundColor: Theme.of(context).secondaryHeaderColor,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 15,
                        children: [
                          Image(
                            image: AssetImage("assets/login/google_2.png"),
                            height: 20,
                          ),
                          Text(
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
