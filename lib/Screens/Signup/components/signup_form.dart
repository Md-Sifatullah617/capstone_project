import 'package:flutter/material.dart';
import 'package:flutter_auth/Authentication/auth_services.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String fullName = "";

  String phoneNumber = "";

  String emailAddress = "";

  String password = "";

  onSubmitted() async {
    print("$fullName $phoneNumber $emailAddress $password");
    await AuthServices()
        .signupUser(fullName, phoneNumber, emailAddress, password, context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CustomTextField(
              hText: "Full Name",
              textinputaction: TextInputAction.next,
              iconss: const Icon(Icons.person),
              onsaved: (fName) {
                setState(() {
                  fullName = fName;
                });
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: CustomTextField(
                hText: "Phone Number",
                textinputaction: TextInputAction.next,
                iconss: const Icon(Icons.phone),
                onsaved: (nPhone) {
                  setState(() {
                    phoneNumber = nPhone;
                  });
                }),
          ),
          CustomTextField(
              hText: "Email Address",
              textinputaction: TextInputAction.next,
              iconss: const Icon(Icons.email),
              onsaved: (email) {
                setState(() {
                  emailAddress = email;
                });
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: CustomTextField(
                hText: "Your Password",
                obscuretext: true,
                textinputaction: TextInputAction.done,
                iconss: const Icon(Icons.lock),
                onsaved: (pwd) {
                  setState(() {
                    password = pwd;
                  });
                }),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              onSubmitted();
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hText,
    required this.iconss,
    required this.onsaved,
    this.keyboadType,
    this.obscuretext,
    this.textinputaction,
  }) : super(key: key);
  final String hText;
  final Icon iconss;
  final Function(String)? onsaved;
  final TextInputType? keyboadType;
  final bool? obscuretext;
  final TextInputAction? textinputaction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboadType ?? TextInputType.none,
      obscureText: obscuretext ?? false,
      textInputAction: textinputaction ?? TextInputAction.next,
      cursorColor: kPrimaryColor,
      onChanged: onsaved,
      decoration: InputDecoration(
        hintText: hText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: iconss,
        ),
      ),
    );
  }
}
