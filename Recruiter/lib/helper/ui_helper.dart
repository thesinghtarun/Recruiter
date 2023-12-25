import 'package:flutter/material.dart';

class UiHelper {
  //Textfield taaaki baaar baar code nah likhna pde😎
  static customTextField(TextEditingController controller, String text,
      IconData iconData, bool toHide) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          )),
    );
  }

  //Creating SnackBar woh empty fie;d click karne pe jo bottom of the screen aa rha nah haa woh hi
  static void showSnackbar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.blue.withOpacity(.8),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
