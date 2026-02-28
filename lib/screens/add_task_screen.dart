import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:td/widgets/custom_textformfield.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                maxLines: 1,
                Controller: nameController,
                title: "Task name",
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your Task name";
                  }
                  return null;
                },
                hint: "task name",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                maxLines: 5,
                Controller: descriptionController,
                title: "Task description",
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please enter your Task description";
                  }
                  return null;
                },
                hint: "task description",
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final prefs = await SharedPreferences.getInstance();

                    String? tasksString = prefs.getString("tasks");

                    List<dynamic> tasksList = [];

                    if (tasksString != null && tasksString.isNotEmpty) {
                      final decoded = jsonDecode(tasksString);

                      if (decoded is List) {
                        tasksList = decoded;
                      }
                    }

                    Map<String, dynamic> newTask = {
                      "name": nameController.text,
                      "desc": descriptionController.text,
                    };

                    tasksList.add(newTask);

                    await prefs.setString("tasks", jsonEncode(tasksList));

                    print(tasksList);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff15B86C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(100),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 40),
                ),
                child: Text(
                  "Let’s Get Started",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
