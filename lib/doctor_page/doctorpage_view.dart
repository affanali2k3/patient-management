import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/assigned_patients/assigned_patients_view.dart';
import 'package:patient_management/colors.dart';
import 'package:patient_management/group_chat/group_chat_view.dart';
import 'package:patient_management/login/login_view.dart';
import 'package:patient_management/pending_requests_doctor/pending_requests_doctor_view.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Portal'),
        toolbarHeight: kToolbarHeight + 40,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.black),
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginPage()), // NewPage is the destination
                            (Route<dynamic> route) =>
                                false, // Always false, so all routes are removed
                          );
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout)),
        backgroundColor: CustomColors.primary,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatPage(
                  user: widget.user,
                ),
              ));
        },
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
        label: const Text('Department Chat'),
        icon: const Icon(Icons.message),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  // Default text style for all spans
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  const TextSpan(
                      text: "Welcome Back, "), // First part of the text
                  TextSpan(
                    text:
                        "Dr. ${widget.user['name']}", // The part you want to style differently
                    style: const TextStyle(
                        color: Color.fromARGB(
                            255, 84, 152, 207)), // Apply different color
                  ),
                ],
              ),
            ),
            Text('${widget.user['speciality']} Specialist'),
            InkWell(
              onTap: () {
                // FirebaseFirestore.instance.collection('collectionPath');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PendingRequestsDoctorPage(user: widget.user),
                    ));
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                height: 200,
                decoration: const BoxDecoration(
                  color: CustomColors.neutral,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Patient Requests',
                          style: TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 70,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AssignedPatientsPage(user: widget.user),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                height: 200,
                decoration: const BoxDecoration(
                  color: CustomColors.neutral,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Assigned Patients',
                          style: TextStyle(fontSize: 26),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 70,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
