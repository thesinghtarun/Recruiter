import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helper/ui_helper.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with SingleTickerProviderStateMixin {
  bool toHide = true;
  //Animation ke liye code
  ParticleOptions particles = const ParticleOptions(
    baseColor: Colors.cyan,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    particleCount: 70,
    spawnMaxRadius: 15.0,
    spawnMaxSpeed: 30.0,
    spawnMinSpeed: 30,
    spawnMinRadius: 7.0,
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //Creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  User? docid = FirebaseAuth.instance.currentUser;

//List of image for automatic image Slideshow
  List<String> imagePaths = [
    'images/login.png',
    'images/login13.png',
    'images/login.png',
    'images/login13.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: const Color.fromARGB(255, 191, 210, 242),
      child: AnimatedBackground(
          vsync: this,
          behaviour: RandomParticleBehaviour(options: particles),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //automatic image slideshow
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height /
                              5, // Set half the screen height
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 3.0,
                          viewportFraction: 1,
                        ),
                        items: imagePaths.map((String imagePath) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        }).toList(),
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
                                  "Welcome..",
                                  style: TextStyle(
                                      fontSize: 26,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              //Calling customTextField() function from UiHelper class taaki code kam dikhe
                              UiHelper.customTextField(
                                  _emailController, "Email", Icons.mail, false),
                              const SizedBox(
                                height: 20,
                              ),
                              UiHelper.customTextField(_newPasswordController,
                                  "New Passsword", Icons.lock, true),
                              const SizedBox(
                                height: 20,
                              ),
                              UiHelper.customTextField(
                                  _confirmPasswordController,
                                  "Confirm Passsword",
                                  Icons.lock,
                                  true),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            validateEmpty(
                                                _emailController.text,
                                                _newPasswordController.text,
                                                _confirmPasswordController
                                                    .text);
                                          },
                                          child: const Text("Reset Password"))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, "/");
                                },
                                child: const Text(
                                  "Return to Login",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          )),
    ));
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
  void validateEmpty(String email, String newPassword, String confirmPassword) {
    if (email == "") {
      UiHelper.showSnackbar(context, "Enter your email id");
    } else if (!isValidEmail(email)) {
      UiHelper.showSnackbar(context, "Enter valid email");
    } else if (newPassword == "") {
      UiHelper.showSnackbar(context, "Password required");
    } else if (confirmPassword == "") {
      UiHelper.showSnackbar(context, "Retype Password");
    } else if (newPassword != confirmPassword) {
      UiHelper.showSnackbar(context, "Password not matched");
    } else {
      updatePasswordInDb(_newPasswordController.text,
          _confirmPasswordController.text, _emailController.text, context);
    }
  }
}

//Checking email format
bool isValidEmail(String email) {
  // Regular expression for a simple email validation
  String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  RegExp regex = RegExp(emailRegex);
  return regex.hasMatch(email);
}

//To update password in cloud firestore
Future<void> updatePasswordInDb(String newPassword, String confirmPassword,
    String email, BuildContext context) async {
  await updatePasswordInAuth(newPassword);
  if (newPassword == confirmPassword) {
    FirebaseFirestore.instance
        .collection('User')
        .where('email', isEqualTo: email)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((doc) {
          FirebaseFirestore.instance
              .collection('User')
              .doc(email)
              .update({'password': newPassword});
          print("Password set");
        });
        UiHelper.showSnackbar(context, "Password Updated Successfully");
        Navigator.pushReplacementNamed(context, "/");
      } else {
        UiHelper.showSnackbar(context, "Password updation failed");
      }
    });
  }
}

//Updating password in auth
Future<void> updatePasswordInAuth(String newPassword) async {
  try {
    User user = FirebaseAuth.instance.currentUser!;
    await user.updatePassword(newPassword);
    print("Password updated successfully!");
  } catch (e) {
    print("Error updating password: $e");
  }
}
