import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/accepted_requests/accepted_requests_view.dart';
import 'package:patient_management/add_request/add_request_view.dart';
import 'package:patient_management/colors.dart';
import 'package:patient_management/login/login_view.dart';
import 'package:patient_management/patient_bookings/patient_bookings_view.dart';
import 'package:patient_management/pending_requests/pending_requests_view.dart';

class ReceptionistPage extends StatefulWidget {
  const ReceptionistPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<ReceptionistPage> createState() => _ReceptionistPageState();
}

class _ReceptionistPageState extends State<ReceptionistPage> {
  String timeDifference = '';
  int shift = 0;

  @override
  void initState() {
    super.initState();
    calculateTimeDifference();
  }

  void calculateTimeDifference() {
    final now = DateTime.now();
    final eightPmToday = DateTime(now.year, now.month, now.day, 17, 0);
    final eightAmToday = DateTime(now.year, now.month, now.day, 8, 0);

    Duration difference;
    if (now.isAfter(eightPmToday)) {
      // If the current time is after 8 PM, calculate the time until 8 PM the next day
      // final eightPmTomorrow = eightPmToday.add(Duration(days: 1));
      // difference = 'eightPmTomorrow.difference(now)';
      // timeDifference = 'Ended';
      shift = 1;
    } else if (now.isBefore(eightAmToday)) {
      // timeDifference = ''
      shift = 2;
      // Calculate the time until 8 PM today
      difference = eightAmToday.difference(now);
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;

      setState(() {
        timeDifference = '${hours}h ${minutes}m';
      });
    } else {
      shift = 3;
      difference = eightPmToday.difference(now);
      final hours = difference.inHours;
      final minutes = difference.inMinutes % 60;

      setState(() {
        timeDifference = '${hours}h ${minutes}m';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receptionist Portal'),
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
                builder: (context) => const AddRequestPage(),
              ));
        },
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
        label: const Text('Add Request'),
        icon: const Icon(Icons.add),
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
                    text: widget
                        .user['name'], // The part you want to style differently
                    style: const TextStyle(
                        color: Color.fromARGB(
                            255, 84, 152, 207)), // Apply different color
                  ),
                ],
              ),
            ),
            const Text('Shift Timings: 8am to 5pm'),
            shift == 1
                ? const Text('Your shift has Ended')
                : shift == 2
                    ? Text('Shift Starting in $timeDifference')
                    : Text('Shift Ending in $timeDifference'),
            InkWell(
              onTap: () {
                // FirebaseFirestore.instance.collection('collectionPath');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientBookingsPage(
                        user: widget.user,
                      ),
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
                          'Patient Bookings',
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
                // FirebaseFirestore.instance.collection('collectionPath');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PendingRequestsPage(
                        user: widget.user,
                      ),
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
                          'Pending Requests',
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
                      builder: (context) => AcceptedRequestsPage(
                        user: widget.user,
                      ),
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
                          'Assigned Requests',
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
