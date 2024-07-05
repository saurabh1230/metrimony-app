
import 'package:bureau_couple/getx/features/widgets/custom_textfield_widget.dart';
import 'package:bureau_couple/getx/utils/sizeboxes.dart';
import 'package:bureau_couple/src/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
class RegisterOne extends StatefulWidget {
   RegisterOne({super.key});

  @override
  State<RegisterOne> createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {
  final usernameController = TextEditingController();

  final firstNameController = TextEditingController();

  final middleNameController = TextEditingController();

  final lastNameController = TextEditingController();

  final emailController = TextEditingController();

  final phNoController = TextEditingController();

  final countryController = TextEditingController();

  final stateController = TextEditingController();
  final districtController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign Up',
                  style: kManrope25Black,),
                sizedBox8(),
                Text("Start your journey towards everlasting love. Create an account and discover meaningful connections",
                  style: kManrope14Medium626262,),
                const SizedBox(height: 23,),
                sizedBox6(),
                CustomTextField(
                  controller: emailController,
                  hintText: 'Username',),

                const SizedBox(height: 20,),
                sizedBox6(),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        showTitle: true,
                        controller: emailController,
                        hintText: 'First Name',),
                    ),
                    sizedBoxW10(),
                    Expanded(
                      child: CustomTextField(
                        showTitle: true,
                        controller: middleNameController,
                        hintText: 'Middle Name (optional)',),
                    ),

                  ],
                ), const SizedBox(height: 20,),
                CustomTextField(
                  showTitle: true,
                  controller: lastNameController,
                  hintText: 'Last Name',),
                const SizedBox(height: 20,),
                CustomTextField(
                  showTitle: true,
                  controller: emailController,
                  hintText: 'Email',),
                const SizedBox(height: 20,),
                CustomTextField(
                  showTitle: true,
                  controller: phNoController,
                  hintText: 'Phone',),
                const SizedBox(height: 20,),
                CustomTextField(
                  readOnly: true,
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      countryListTheme: CountryListThemeData(
                        flagSize: 25,
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                        bottomSheetHeight: 500,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      onSelect: (Country country) {
                        setState(() {
                        String  selectedCountryName = country.displayName.split(' ')[0] ?? '';
                        countryController.text = selectedCountryName;
                        });
                        setState(() {
                          // SharedPrefs().setCountry(selectedCountryName);
                          // SharedPrefs().setCountryCode(country.countryCode);
                        });
                      },
                    );
                  },
                  showTitle: true,
                  controller: countryController,
                  hintText: 'Country',),
                const SizedBox(height: 20,),
                CustomTextField(
                  showTitle: true,
                  controller: stateController,
                  hintText: 'State',),
                const SizedBox(height: 20,),
                CustomTextField(
                  showTitle: true,
                  controller: districtController,
                  hintText: 'District',),
                const SizedBox(height: 20,),
                // CustomTextField(
                //   showTitle: true,
                //   isPassword: true,
                //   controller: passwordController,
                //   hintText: 'Password',),
              ],
            ),
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}
