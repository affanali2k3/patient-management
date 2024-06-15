import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientCard extends StatefulWidget {
  const PatientCard({super.key, required this.pendingRequests, this.actions});

  final QueryDocumentSnapshot pendingRequests;
  final Widget? actions;

  @override
  State<PatientCard> createState() => _CardState();
}

class _CardState extends State<PatientCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Patient Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Flexible(child: Text(widget.pendingRequests['patient_name'])),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Flexible(child: Text(widget.pendingRequests['patient_number'])),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(widget.pendingRequests['patient_gender']),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Location',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Flexible(child: Text(widget.pendingRequests['patient_location'])),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Age',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(widget.pendingRequests['patient_age'].toString()),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        widget.pendingRequests.data().toString().contains('speciality')
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Speciality',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(widget.pendingRequests['speciality']),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        ),
        widget.pendingRequests.data().toString().contains('doctor_name')
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Doctor Name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(widget.pendingRequests['doctor_name'] ?? ''),
                ],
              )
            : const SizedBox(),
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(child: Text(widget.pendingRequests['patient_problem'])),
          ],
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
              'Patient Medical History',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Flexible(child: Text(widget.pendingRequests['patient_history'])),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        widget.actions ?? const SizedBox()
      ],
    );
  }
}
