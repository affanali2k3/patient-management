import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviousRecords extends StatefulWidget {
  const PreviousRecords(
      {super.key, required this.user, required this.patientNumber});

  final Map<String, String> user;
  final String patientNumber;

  @override
  State<PreviousRecords> createState() => _PreviousRecordsState();
}

class _PreviousRecordsState extends State<PreviousRecords> {
  List<QueryDocumentSnapshot>? pendingRequests;
  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    final data = await FirebaseFirestore.instance
        .collection('past_records')
        .where("patient_number", isEqualTo: widget.patientNumber)
        .get();

    setState(() {
      pendingRequests = data.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient`s Previous Records'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: pendingRequests == null
              ? const CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  primary: true,
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
                              'Treated By',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['doctor_name']),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Doctor Speciality',
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
                              'Receptionist',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(pendingRequests![index]['receptionist']),
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
                      ],
                    ),
                  ),
                )),
    );
  }
}
