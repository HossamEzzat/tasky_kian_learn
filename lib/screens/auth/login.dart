import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:td/widgets/custom_textformfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                Controller: controller,
                title: "enter email",
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
                hint: "email",
                maxLines: 1,
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                Controller: controller2,
                title: "enter password",
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your Password";
                  }
                  return null;
                },
                hint: "password",
                maxLines: 1,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Perform login action
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: controller.text,
                      password: controller2.text,
                    );
                  }
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
