import 'package:flutter/material.dart';
import 'package:recruiter/helper/ui_helper.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController _jobCategoryController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 231, 145, 174),
            Color.fromARGB(255, 132, 167, 197)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        //  bottomNavigationBar: BottomNavigationBarForApp(indexNum:2,),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("Upload job now "),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 144, 182, 140),
                      Color.fromARGB(255, 74, 77, 80)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.9])),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  color: Colors.black38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Please fill all feilds ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      UiHelper.customTextField(
                        _jobCategoryController,
                        "Job Category",
                        Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UiHelper.customTextField(
                        _jobTitleController,
                        "Job Title",
                        Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UiHelper.customTextField(
                        _jobCategoryController,
                        "Job Description",
                        Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            UiHelper.showSnackbar(context, "Button Clicked");
                          },
                          child: const Text(
                            "Add",
                            style: TextStyle(fontSize: 30),
                          )),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
