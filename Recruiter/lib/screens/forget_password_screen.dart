import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recruiter/screens/login_screen.dart';
import '../helper/ui_helper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  String loginUrlImage = 'images/bgWallpaper1.jpg';

  //Creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  User? docid = FirebaseAuth.instance.currentUser;

  void forgetPasswordSubmitform() async {
    try {
      await _mAuth.sendPasswordResetEmail(
        email: _emailController.text,
      );

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        //automatic image slideshow
        Image.asset(
          "images/bgWallpaper1.jpg",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          alignment: FractionalOffset(_animation.value, 0),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: const Text(
                    "Forgot Passwoord:(",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                //Calling customTextField() function from UiHelper class taaki code kam dikhe
                UiHelper.customEmailPasswordTextField(
                    _emailController, "Email", Icons.mail, false),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              validateEmpty(_emailController.text);
                            },
                            child: const Text("Reset Password"))),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ]),
    );
  }

  Future<void> resetPassword() async {
    try {
      await _mAuth.sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      UiHelper.showSnackbar(context, "Reset email has been sent");
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      UiHelper.showSnackbar(context, e.toString());
    }
  }

  //Validating text fields checking if it is null
  void validateEmpty(String email) {
    if (email == "") {
      UiHelper.showSnackbar(context, "Enter your email id");
    } else if (!isValidEmail(email)) {
      UiHelper.showSnackbar(context, "Enter valid email");
    } else {
      forgetPasswordSubmitform();
    }
  }
}

//Checking email format
bool isValidEmail(String email) {
  // Regular expression for a simple email validation
  String emailRegex = r'^[a-zA-Z_]+[\w-]*@(gmail\.)+[com]';
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}
