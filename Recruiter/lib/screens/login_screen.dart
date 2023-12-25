import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helper/ui_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
  final TextEditingController _passwordController = TextEditingController();
  //Creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;

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
                                height: 10,
                              ),

                              //Calling customTextField() function from UiHelper class taaki code kam dikhe
                              UiHelper.customTextField(_passwordController,
                                  "Password", Icons.lock, true),

                              Container(
                                alignment: Alignment.topRight,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Text(
                                  "Forget Password?",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            validateEmpty(
                                                _emailController.text
                                                    .toString(),
                                                _passwordController.text
                                                    .toString());
                                          },
                                          child: const Text("Login"))),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/SignUpScreen");
                                    },
                                    child: const Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ]),
              ),
            ),
          )),
    ));
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _mAuth.signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      UiHelper.showSnackbar(context, "User Logged in");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    } catch (e) {
      // ignore: use_build_context_synchronously
      UiHelper.showSnackbar(context, e.toString());
    }
  }

  //Validating text fields checking if it is null
  void validateEmpty(String email, String password) {
    if (email == "") {
      UiHelper.showSnackbar(context, "Enter your email id");
    } else if (password == "") {
      UiHelper.showSnackbar(context, "Enter Password");
    } else if (!isValidEmail(email)) {
      UiHelper.showSnackbar(context, "Enter valid email");
    } else {
      logIn(_emailController.text.toString(),
          _passwordController.text.toString());
    }
  }

  //Checking email format
  bool isValidEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }
}
