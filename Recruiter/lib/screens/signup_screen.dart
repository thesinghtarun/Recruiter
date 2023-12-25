import 'package:animated_background/animated_background.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  //List of image for automatic image slideshow
  List<String> imagePaths = [
    'images/login.png',
    'images/login_logo.png',
    'images/login.png',
    'images/login_logo.png',
  ];
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  //creating firebaseAuth instance
  final FirebaseAuth _mAuth = FirebaseAuth.instance;

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //automatic image slideshow
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height /
                              6, // Set half the screen height
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          viewportFraction: 0.6,
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

                      //Calling customTextField() function from UiHelper class taaki code kam dikhe
                      UiHelper.customTextField(
                          _nameController, "Name", Icons.person, false),
                      const SizedBox(
                        height: 10,
                      ),

                      //Calling customTextField() function from UiHelper class taaki code kam dikhe
                      UiHelper.customTextField(
                          _emailController, "Email", Icons.mail, false),
                      const SizedBox(
                        height: 10,
                      ),

                      //Calling customTextField() function from UiHelper class taaki code kam dikhe
                      UiHelper.customTextField(
                          _passwordController, "Password", Icons.lock, true),
                      const SizedBox(
                        height: 10,
                      ),

                      //Calling customTextField() function from UiHelper class taaki code kam dikhe
                      UiHelper.customTextField(
                          _phoneController, "Phone", Icons.phone, false),
                      const SizedBox(
                        height: 10,
                      ),

                      //Calling customTextField() function from UiHelper class taaki code kam dikhe
                      UiHelper.customTextField(
                          _cityController, "City", Icons.gps_fixed, false),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(

                                    //Calling signUp method to create user in firebase authentication
                                    onPressed: () {
                                      validateTextField(
                                        _nameController.text.toString(),
                                        _emailController.text.toString(),
                                        _passwordController.text.toString(),
                                        _phoneController.text.toString(),
                                        _cityController.text.toString(),
                                      );
                                    },
                                    child: const Text("Sign Up"))),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account",
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
                              Navigator.pushReplacementNamed(context, "/");
                            },
                            child: const Text(
                              "Login",
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
            ),
          ),
        ),
      ),
    );
  }

//Checking email format
  bool isValidEmail(String email) {
    // Regular expression for a simple email validation
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

//Validating textfields checking if it is null
  void validateTextField(
      String name, String email, String password, String phone, String city) {
    if (name == "") {
      UiHelper.showSnackbar(context, "Name required");
    } else if (email == "") {
      UiHelper.showSnackbar(context, "Email required");
    } else if (!isValidEmail(email)) {
      UiHelper.showSnackbar(context, "Enter valid email");
    } else if (password == "") {
      UiHelper.showSnackbar(context, "Password required");
    } else if (phone == "") {
      UiHelper.showSnackbar(context, "Phone Number required");
    } else if (phone.length < 10 || phone.length > 10) {
      UiHelper.showSnackbar(context, "Enter valid phone number");
    } else if (city == "") {
      UiHelper.showSnackbar(context, "City required");
    } else {
      signUp(_emailController.text.toString(),
          _passwordController.text.toString());
      addUser(
          _nameController.text.toString(),
          _emailController.text.toString(),
          _passwordController.text.toString(),
          _phoneController.text.toString(),
          _cityController.text.toString());
    }
  }

  //To create user in firebase auth
  Future<void> signUp(String email, String password) async {
    await _mAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //To add user in firestore database
  Future<void> addUser(String name, String email, String password, String phone,
      String city) async {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    return users.add({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'city': city,
    }).then((value) {
      UiHelper.showSnackbar(context, "User Added Successfully");
    }).catchError((error) {
      UiHelper.showSnackbar(context, error.toString());
    });
  }
}
