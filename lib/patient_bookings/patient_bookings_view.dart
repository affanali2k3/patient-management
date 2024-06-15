import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_management/patient_card/card.dart';
import 'package:patient_management/patient_bookings/bloc/patient_bookings_bloc.dart';

class PatientBookingsPage extends StatefulWidget {
  const PatientBookingsPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<PatientBookingsPage> createState() => _PatientBookingsPageState();
}

class _PatientBookingsPageState extends State<PatientBookingsPage> {
  List<QueryDocumentSnapshot>? pendingRequests;
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    final data = await FirebaseFirestore.instance.collection('bookings').get();

    setState(() {
      pendingRequests = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient Bookings'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 113, 184, 241),
        ),
        body: BlocListener<PatientBookingsBloc, PatientBookingsState>(
          listener: (context, state) {
            if (state is PatientBookingsAcceptedState) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PatientBookingsPage(user: widget.user),
                  ));
            }
          },
          child: SafeArea(
            minimum: const EdgeInsets.all(10),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('bookings')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    return const Text("No data available");
                  }
                  final pendingRequests = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: pendingRequests.length,
                      itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 12,
                                      color: Color.fromARGB(28, 0, 0, 0))
                                ]),
                            child: PatientCard(
                              pendingRequests: pendingRequests[index],
                              actions: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      String specialityValue = 'Eye';

                                      showDialog(
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                            builder: (context, setStateDB) {
                                          return AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                    'Assign this patient to a speciality'),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment
                                                  //         .spaceBetween,
                                                  children: [
                                                    const Text('Speciality',
                                                        style: TextStyle(
                                                            fontSize: 18)),
                                                    DropdownButton(
                                                        value: specialityValue,
                                                        items: const [
                                                          DropdownMenuItem(
                                                              value: 'Eye',
                                                              child:
                                                                  Text('Eye')),
                                                          DropdownMenuItem(
                                                              value: 'ENT',
                                                              child:
                                                                  Text('ENT')),
                                                          DropdownMenuItem(
                                                              value: 'Neuro',
                                                              child: Text(
                                                                  'Neuro')),
                                                          DropdownMenuItem(
                                                              value: 'Surgeon',
                                                              child: Text(
                                                                  'Surgeon')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Cardiology',
                                                              child: Text(
                                                                  'Cardiology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Dermatology',
                                                              child: Text(
                                                                  'Dermatology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Gastroenterology',
                                                              child: Text(
                                                                  'Gastroenterology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Pediatrics',
                                                              child: Text(
                                                                  'Pediatrics')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Orthopedics',
                                                              child: Text(
                                                                  'Orthopedics')),
                                                          DropdownMenuItem(
                                                              value: 'Urology',
                                                              child: Text(
                                                                  'Urology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Psychiatry',
                                                              child: Text(
                                                                  'Psychiatry')),
                                                          DropdownMenuItem(
                                                              value: 'Oncology',
                                                              child: Text(
                                                                  'Oncology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Gynecology',
                                                              child: Text(
                                                                  'Gynecology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Neurology',
                                                              child: Text(
                                                                  'Neurology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Radiology',
                                                              child: Text(
                                                                  'Radiology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Endocrinology',
                                                              child: Text(
                                                                  'Endocrinology')),
                                                          DropdownMenuItem(
                                                              value:
                                                                  'Pulmonology',
                                                              child: Text(
                                                                  'Pulmonology')),
                                                        ],
                                                        onChanged:
                                                            (newDropdownValue) =>
                                                                {
                                                                  setStateDB(
                                                                      () {
                                                                    if (newDropdownValue !=
                                                                        null) {
                                                                      specialityValue =
                                                                          newDropdownValue;
                                                                    }
                                                                  })
                                                                }),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            PatientBookingsBloc>()
                                                        .add(PatientBookingsAcceptEvent(
                                                            pendingRequests:
                                                                pendingRequests[
                                                                    index],
                                                            receptionist: widget
                                                                .user['email'],
                                                            speciality:
                                                                specialityValue));
                                                  },
                                                  child: const Text(
                                                    'Put Request',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ],
                                          );
                                        }),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(2, 2),
                                                color: Color.fromARGB(
                                                    144, 0, 0, 0),
                                                blurRadius: 3)
                                          ],
                                          color: const Color.fromARGB(
                                              255, 119, 230, 123),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text('Accept'),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.read<PatientBookingsBloc>().add(
                                          PatientBookingsRejectEvent(
                                              id: pendingRequests[index].id));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30),
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(2, 2),
                                                color: Color.fromARGB(
                                                    144, 0, 0, 0),
                                                blurRadius: 3)
                                          ],
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Text('Reject'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                }),
          ),
        ));
  }
}
