import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiHelper {
  //Other textFields
  static customTextField(
      TextEditingController controller, String text, IconData iconData) {
    return TextField(
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ],
      decoration: InputDecoration(
        labelText: text,
        hoverColor: Colors.white,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: const Color.fromARGB(73, 124, 180, 199),
      ),
    );
  }

  //Password textField
  static customEmailPasswordTextField(TextEditingController controller,
      String text, IconData iconData, bool toHide) {
    return TextField(
      controller: controller,
      obscureText: toHide,
      decoration: InputDecoration(
        hoverColor: Colors.white,
        labelText: text,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: const Color.fromARGB(73, 124, 180, 199),
      ),
    );
  }

  //Numeric Textfield(phone number) taaaki baaar baar code nah likhna pde😎
  static customNumericTextField(
      TextEditingController controller, String text, IconData iconData) {
    return TextField(
      controller: controller,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        labelText: text,
        prefixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: const Color.fromARGB(73, 124, 180, 199),
      ),
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
