import 'package:flutter/material.dart';

class SignUpDataModel extends ChangeNotifier {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phNoController;
  late TextEditingController createController;

  SignUpDataModel() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phNoController = TextEditingController();
    createController = TextEditingController();
  }
}
