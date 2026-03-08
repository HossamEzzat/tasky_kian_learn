import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:td/models/task_model.dart';

import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<TaskModel> tasksList = [];

  @override
  void initState() {
    super.initState();
    loadName();
    loadTasks();
  }

  loadName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "Guest";
    setState(() {});
  }

  loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasks = prefs.getString("tasks");

    if (tasks != null) {
      final decoded = jsonDecode(tasks);

      final taskList = List.from(
        decoded,
      ).map((e) => TaskModel.fromJson(e)).toList();

      setState(() {
        tasksList = taskList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 8,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          ).then((_) => loadTasks());
        },
        label: const Text("Add Task"),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xff15B86C),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  SvgPicture.asset("assets/Vector.svg", height: 35),
                  const SizedBox(width: 10),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Evening, ${name ?? "Guest"}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "One task at a time. One step closer.",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// Title
              Text(
                "Yuhuu! Your work is",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              Row(
                children: [
                  Text(
                    "almost done!",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset("assets/hand.svg", height: 30),
                ],
              ),

              const SizedBox(height: 30),

              /// Tasks List
              Expanded(
                child: tasksList.isEmpty
                    ? Center(
                        child: Text(
                          "No Tasks Yet\nClick Add Task",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) {
                          final task = tasksList[index];

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),

                            decoration: BoxDecoration(
                              color: const Color(0xff1E293B),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),

                            child: ListTile(
                              leading: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff15B86C,
                                  ).withOpacity(.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Color(0xff15B86C),
                                ),
                              ),

                              title: Text(
                                task.taskName,
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              subtitle: Text(
                                task.taskDesc,
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),

                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
