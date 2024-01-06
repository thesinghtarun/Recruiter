import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _mAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 191, 210, 242),
      body: Center(
        child: Column(
          children: [
            const Text("Profile"),
            ElevatedButton(
                onPressed: () {
                  _mAuth.signOut();
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
