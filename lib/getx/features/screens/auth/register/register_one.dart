// import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
// import 'package:bureau_couple/getx/utils/sizeboxes.dart';
// import 'package:bureau_couple/src/constants/fonts.dart';
// import 'package:flutter/material.dart';
//
//
//
// class RegisterOne extends StatefulWidget {
//
//   const RegisterOne({super.key, });
//   @override
//   State<RegisterOne> createState() => _RegisterOneState();
//
// }
//
// class _RegisterOneState extends State<RegisterOne> {
//
//
//
//   final usernameController = TextEditingController();
//   final firstNameController = TextEditingController();
//
//   final middleNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phNoController = TextEditingController();
//   final countryController = TextEditingController();
//   final stateController = TextEditingController();
//   final passwordController = TextEditingController();
//
//
//   // final _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Sign Up',
//                   style: kManrope25Black,),
//                 sizedBox8(),
//                 Text("Start your journey towards everlasting love. Create an account and discover meaningful connections",
//                   style: kManrope14Medium626262,),
//                 const SizedBox(height: 23,),
//                 sizedBox6(),
//                 CustomTextField(
//                   controller: emailController,
//                   hintText: 'Username',),
//
//                 const SizedBox(height: 20,),
//                 sizedBox6(),
//                 Row(
//                   children: [
//                     CustomTextField(
//                       showTitle: true,
//                       controller: emailController,
//                       hintText: 'First Name',),
//                     CustomTextField(
//                       showTitle: true,
//                       controller: middleNameController,
//                       hintText: 'Middle Name (optional)',),
//                     CustomTextField(
//                       showTitle: true,
//                       controller: lastNameController,
//                       hintText: 'Last Name',),
//                   ],
//                 ),
//                 const SizedBox(height: 20,),
//                 CustomTextField(
//                   showTitle: true,
//                   controller: emailController,
//                   hintText: 'Email',),
//                 const SizedBox(height: 20,),
//                 CustomTextField(
//                   showTitle: true,
//                   controller: phNoController,
//                   hintText: 'Phone',),
//                 const SizedBox(height: 20,),
//                 CustomTextField(
//                   showTitle: true,
//                   controller: countryController,
//                   hintText: 'Country',),
//                 const SizedBox(height: 20,),
//                 CustomTextField(
//                   showTitle: true,
//                   controller: stateController,
//                   hintText: 'State',),
//                 const SizedBox(height: 20,),
//                 CustomTextField(
//                   showTitle: true,
//                   isPassword: true,
//                   controller: passwordController,
//                   hintText: 'Password',),
//               ],
//             ),
//             const SizedBox(height: 24,),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
