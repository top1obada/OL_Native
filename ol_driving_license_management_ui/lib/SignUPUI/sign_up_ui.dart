import 'package:flutter/material.dart';
import 'package:my_widgets/CountriesWidgets/countries_drop_down_list_widget.dart';
import 'package:my_widgets/DateTimeWidgets/wd_date_time.dart';
import 'package:ol_driving_license_management_dto/AddressDTOs/address_dto.dart';
import 'package:ol_driving_license_management_dto/ContactInformationDTOs/contactinformation_dto.dart';
import 'package:ol_driving_license_management_dto/SignUpDTOs/sign_up_dto.dart';
import 'package:ol_driving_license_management_providers/BaseCurrentLoginInfoProviders/base_current_login_info_provider.dart';
import 'package:ol_driving_license_management_providers/CaseProviders/cases_Retriving_provider.dart';
import 'package:ol_driving_license_management_ui/MainUI/main_screen_ui.dart';

import 'package:ol_driving_license_management_widgets/SomeWidgets/gender_selector_widget.dart';
import 'package:provider/provider.dart';
import 'package:ol_driving_license_management_dto/LoginDTOs/login_dto.dart';
import 'package:ol_driving_license_management_dto/PersonDTOs/person_dto.dart';
import 'package:my_widgets/TextsFiledsFunctions/TextFileds.dart';
import 'package:my_widgets/Validators/vd_not_empty.dart';
import 'package:my_widgets/TextFormsFiledsWidgets/PasswordTextFormFileds/native_password_text_form_filed.dart';

class UISignUp extends StatefulWidget {
  const UISignUp({super.key});

  @override
  State<UISignUp> createState() => _SignUpScreenUIStateState();
}

class _SignUpScreenUIStateState extends State<UISignUp> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for each text field
  final TextEditingController nationalNumberController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  String? nationality;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController buildingNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String gender = ''; // selected gender

  @override
  void dispose() {
    nationalNumberController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    lastNameController.dispose();
    birthdayController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    countryController.dispose();
    cityController.dispose();
    townController.dispose();
    streetController.dispose();
    buildingNameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (gender.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select gender')));
      return;
    }

    if (nationality == null || nationality!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select nationality')),
      );
      return;
    }

    final person = ClsPersonDTO(
      nationalNumber: nationalNumberController.text.trim(),
      firstName: firstNameController.text.trim(),
      secondName: secondNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      birthday: DateTime.tryParse(birthdayController.text.trim()),
      gender: gender,
      nationalityName: nationality?.trim(),
      contactInformation: ClsContactInformationDTO(
        phoneNumber: phoneNumberController.text.trim(),
        email: emailController.text.trim(),
      ),
      address: ClsAddressDTO(
        countryName: countryController.text.trim(),
        city: cityController.text.trim(),
        town: townController.text.trim(),
        street: streetController.text.trim(),
        buldingName: buildingNameController.text.trim(),
      ),
    );

    final login = ClsLoginDataDTO(
      userName: userNameController.text.trim(),
      password: passwordController.text.trim(),
    );

    final signupDTO = ClsSignUpDTO(person: person, login: login);

    PVSignUp p = context.read<PVSignUp>();

    final result = await p.signUp(signupDTO);

    if (!mounted) return;

    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    PVBaseCurrentLogin currentLoggedInProvider = context.read<PVSignUp>();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:
            (innerContext) => MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: currentLoggedInProvider),
                ChangeNotifierProvider(create: (con) => PVRetrivingCases()),
              ],
              child: const UIMainScreen(),
            ),
      ),
      (Route<dynamic> rr) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Register New Account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // SECTION 1: Personal Information
                Text(
                  'Personal Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                TextFields.buildInputField(
                  'National Number',
                  nationalNumberController,

                  validator:
                      (val) => EmptyValidator.validateNotEmpty(
                        val,
                        'national number',
                      ),
                ),
                TextFields.buildInputField(
                  'First Name',
                  firstNameController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'first name'),
                ),
                TextFields.buildInputField(
                  'Second Name',
                  secondNameController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'second name'),
                ),
                TextFields.buildInputField(
                  'Last Name',
                  lastNameController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'last name'),
                ),

                WDBirthDatePicker(
                  controller: birthdayController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'birth date'),
                ),

                WDGenderSelector(onChanged: (val) => gender = val),
                const SizedBox(height: 10),
                WDCountriesDropdown(
                  text: 'Nationality',
                  onChanged: (val) => nationality = val,
                ),

                const Divider(),

                // SECTION 2: Contact Information
                Text(
                  'Contact Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                TextFields.buildInputField(
                  'Phone Number',
                  phoneNumberController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'phone number'),
                ),
                TextFields.buildInputField(
                  'Email',
                  emailController,
                  validator:
                      (val) => EmptyValidator.validateNotEmpty(val, 'email'),
                ),

                const Divider(),

                // SECTION 3: Address Information
                Text(
                  'Address Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                WDCountriesDropdown(
                  text: 'Current Residence',
                  onChanged: (val) => countryController.text = val ?? '',
                ),

                const SizedBox(height: 14),

                TextFields.buildInputField(
                  'City',
                  cityController,
                  validator:
                      (val) => EmptyValidator.validateNotEmpty(val, 'city'),
                ),
                TextFields.buildInputField(
                  'Town',
                  townController,
                  validator:
                      (val) => EmptyValidator.validateNotEmpty(val, 'town'),
                ),
                TextFields.buildInputField(
                  'Street',
                  streetController,
                  validator:
                      (val) => EmptyValidator.validateNotEmpty(val, 'street'),
                ),
                TextFields.buildInputField(
                  'Building Name',
                  buildingNameController,
                  validator:
                      (val) =>
                          EmptyValidator.validateNotEmpty(val, 'building name'),
                ),

                const Divider(),

                // SECTION 4: Account Credentials
                Text(
                  'Account Credentials',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                TextFields.buildInputField(
                  'Username',
                  userNameController,
                  validator:
                      (val) => EmptyValidator.validateNotEmpty(val, 'username'),
                ),
                WDNativePasswordTextFormField(controller: passwordController),

                const SizedBox(height: 100), // space for the button
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _signUp,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700], // suitable blue
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Register'),
            ),
          ),
        ),
      ),
    );
  }
}
