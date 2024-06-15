import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_management/pending_requests/pending_requests_view.dart';

class DoctorsApplicationPage extends StatefulWidget {
  const DoctorsApplicationPage(
      {super.key, required this.user, required this.requestId});

  final Map<String, String> user;
  final String requestId;

  @override
  State<DoctorsApplicationPage> createState() => _DoctorsApplicationPageState();
}

class _DoctorsApplicationPageState extends State<DoctorsApplicationPage> {
  List<QueryDocumentSnapshot>? pendingRequests;
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    final data = await FirebaseFirestore.instance
        .collection('requests_applications')
        .where("request_id", isEqualTo: widget.requestId)
        .where("status", isEqualTo: "Pending")
        .get();

    setState(() {
      pendingRequests = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors Applications'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: pendingRequests == null
              ? const CircularProgressIndicator()
              : ListView.builder(
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
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Patient Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['patient_name']),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Speciality Required',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['speciality']),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Doctor',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['doctor']),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Doctor Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['doctor_name']),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.8,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Text(
                              'Patient Problem',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text(pendingRequests![index]
                                    ['patient_problem'])),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('requests_applications')
                                    .doc(pendingRequests![index].id)
                                    .update({"status": "Accepted"});

                                final docData = {
                                  "doctor": pendingRequests![index]['doctor'],
                                  "doctor_name": pendingRequests![index]
                                      ['doctor_name'],
                                  "patient_name": pendingRequests![index]
                                      ['patient_name'],
                                  "patient_problem": pendingRequests![index]
                                      ['patient_problem'],
                                  "patient_number": pendingRequests![index]
                                      ['patient_number'],
                                  "patient_age": pendingRequests![index]
                                      ['patient_age'],
                                  "patient_gender": pendingRequests![index]
                                      ['patient_gender'],
                                  "patient_history": pendingRequests![index]
                                      ['patient_history'],
                                  "patient_location": pendingRequests![index]
                                      ['patient_location'],
                                  "receptionist": pendingRequests![index]
                                      ['receptionist'],
                                  "speciality": pendingRequests![index]
                                      ['speciality'],
                                };

                                await FirebaseFirestore.instance
                                    .collection('requests_accepted')
                                    .add(docData);

                                await FirebaseFirestore.instance
                                    .collection('requests_pending')
                                    .doc(widget.requestId)
                                    .delete();

                                // await FirebaseFirestore.instance
                                //     .collection('past_records')
                                //     .add(docData);

                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PendingRequestsPage(
                                        user: widget.user,
                                      ),
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 2),
                                          color: Color.fromARGB(144, 0, 0, 0),
                                          blurRadius: 3)
                                    ],
                                    color: const Color.fromARGB(
                                        255, 119, 230, 123),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text('Accept'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('requests_applications')
                                    .doc(pendingRequests![index].id)
                                    .update({"status": "Rejected"});

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DoctorsApplicationPage(
                                              user: widget.user,
                                              requestId: widget.requestId),
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(2, 2),
                                          color: Color.fromARGB(144, 0, 0, 0),
                                          blurRadius: 3)
                                    ],
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text('Reject'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
    );
  }
}
