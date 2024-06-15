import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/patient_card/card.dart';
import 'package:patient_management/previous_records/previous_records_view.dart';

class PendingRequestsDoctorPage extends StatefulWidget {
  const PendingRequestsDoctorPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<PendingRequestsDoctorPage> createState() =>
      _PendingRequestsDoctorPageState();
}

class _PendingRequestsDoctorPageState extends State<PendingRequestsDoctorPage> {
  List<QueryDocumentSnapshot>? pendingRequests = [];
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    final data = await FirebaseFirestore.instance
        .collection('requests_pending')
        .where('speciality', isEqualTo: widget.user['speciality'])
        .get();

    final filterData = await FirebaseFirestore.instance
        .collection('requests_applications')
        .where('doctor', isEqualTo: widget.user['email'])
        .get();

    final filteredRequestIds =
        filterData.docs.map((doc) => doc['request_id']).toList();

    final finalPendingRequests =
        data.docs.where((doc) => !filteredRequestIds.contains(doc.id)).toList();

    setState(() {
      pendingRequests = finalPendingRequests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient Requests'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 113, 184, 241),
        ),
        body: SafeArea(
            minimum: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: pendingRequests!.length,
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
                      pendingRequests: pendingRequests![index],
                      actions: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PreviousRecords(
                                        user: widget.user,
                                        patientNumber: pendingRequests![index]
                                            ['patient_number']),
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Color.fromARGB(144, 0, 0, 0),
                                        blurRadius: 3)
                                  ],
                                  color:
                                      const Color.fromARGB(255, 113, 184, 241),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text('Patient`s Previous Records'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () async {
                              final data = <String, dynamic>{
                                "doctor":
                                    FirebaseAuth.instance.currentUser!.email!,
                                "doctor_name": widget.user['name'],
                                "patient_name": pendingRequests![index]
                                    ['patient_name'],
                                "patient_gender": pendingRequests![index]
                                    ['patient_gender'],
                                "patient_problem": pendingRequests![index]
                                    ['patient_problem'],
                                "patient_history": pendingRequests![index]
                                    ['patient_history'],
                                "patient_location": pendingRequests![index]
                                    ['patient_location'],
                                "patient_number": pendingRequests![index]
                                    ['patient_number'],
                                "patient_age": pendingRequests![index]
                                    ['patient_age'],
                                "receptionist": pendingRequests![index]
                                    ['receptionist'],
                                "speciality": pendingRequests![index]
                                    ['speciality'],
                                "request_id": pendingRequests![index].id,
                                "status": "Pending"
                              };
                              await FirebaseFirestore.instance
                                  .collection('requests_applications')
                                  .add(data);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PendingRequestsDoctorPage(
                                            user: widget.user),
                                  ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Application sent to receptionist')));
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(2, 2),
                                        color: Color.fromARGB(144, 0, 0, 0),
                                        blurRadius: 3)
                                  ],
                                  color:
                                      const Color.fromARGB(255, 113, 184, 241),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text('Apply'),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
