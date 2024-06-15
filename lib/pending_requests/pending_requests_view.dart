import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/patient_card/card.dart';
import 'package:patient_management/doctors_applications/doctors_applications_view.dart';
import 'package:patient_management/previous_records/previous_records_view.dart';

class PendingRequestsPage extends StatefulWidget {
  const PendingRequestsPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<PendingRequestsPage> createState() => _PendingRequestsPageState();
}

class _PendingRequestsPageState extends State<PendingRequestsPage> {
  List<QueryDocumentSnapshot>? pendingRequests;
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    final data = await FirebaseFirestore.instance
        .collection('requests_pending')
        .where("receptionist", isEqualTo: widget.user['email'])
        .get();

    setState(() {
      pendingRequests = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Requests'),
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
        centerTitle: true,
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: pendingRequests == null
              ? const CircularProgressIndicator()
              : ListView.builder(
                  // shrinkWrap: true,
                  // primary: true,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DoctorsApplicationPage(
                                            user: widget.user,
                                            requestId:
                                                pendingRequests![index].id),
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
                              child: const Text('See Doctors Applications'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
