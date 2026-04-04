import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:td/widgets/custom_textformfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
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
                "Signup",
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
                    // Perform signup logic here
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: controller.text,
                      password: controller2.text,
                    );
                  }
                },
                child: Text("Signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
