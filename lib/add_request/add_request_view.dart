import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRequestPage extends StatefulWidget {
  const AddRequestPage({super.key});

  @override
  State<AddRequestPage> createState() => _AddRequestPageState();
}

class _AddRequestPageState extends State<AddRequestPage> {
  String specialityValue = 'Eye';
  String genderValue = 'Male';
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _historyController = TextEditingController();
  final _problemController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Request'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Speciality', style: TextStyle(fontSize: 18)),
                  DropdownButton(
                      value: specialityValue,
                      items: const [
                        DropdownMenuItem(value: 'Eye', child: Text('Eye')),
                        DropdownMenuItem(value: 'ENT', child: Text('ENT')),
                        DropdownMenuItem(value: 'Neuro', child: Text('Neuro')),
                        DropdownMenuItem(
                            value: 'Surgeon', child: Text('Surgeon')),
                        DropdownMenuItem(
                            value: 'Cardiology', child: Text('Cardiology')),
                        DropdownMenuItem(
                            value: 'Dermatology', child: Text('Dermatology')),
                        DropdownMenuItem(
                            value: 'Gastroenterology',
                            child: Text('Gastroenterology')),
                        DropdownMenuItem(
                            value: 'Pediatrics', child: Text('Pediatrics')),
                        DropdownMenuItem(
                            value: 'Orthopedics', child: Text('Orthopedics')),
                        DropdownMenuItem(
                            value: 'Urology', child: Text('Urology')),
                        DropdownMenuItem(
                            value: 'Psychiatry', child: Text('Psychiatry')),
                        DropdownMenuItem(
                            value: 'Oncology', child: Text('Oncology')),
                        DropdownMenuItem(
                            value: 'Gynecology', child: Text('Gynecology')),
                        DropdownMenuItem(
                            value: 'Neurology', child: Text('Neurology')),
                        DropdownMenuItem(
                            value: 'Radiology', child: Text('Radiology')),
                        DropdownMenuItem(
                            value: 'Endocrinology',
                            child: Text('Endocrinology')),
                        DropdownMenuItem(
                            value: 'Pulmonology', child: Text('Pulmonology')),
                        DropdownMenuItem(
                            value: 'Surgeon', child: Text('Surgeon'))
                      ],
                      onChanged: (newDropdownValue) => {
                            setState(() {
                              if (newDropdownValue != null) {
                                specialityValue = newDropdownValue;
                              }
                            })
                          }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text('Patient Name', style: TextStyle(fontSize: 18)),
                ],
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text('Patient Number', style: TextStyle(fontSize: 18)),
                ],
              ),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: 'Number', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text('Patient Age', style: TextStyle(fontSize: 18)),
                ],
              ),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: 'Age', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text('Patient Location', style: TextStyle(fontSize: 18)),
                ],
              ),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                    hintText: 'Location', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Gender', style: TextStyle(fontSize: 18)),
                  DropdownButton(
                      value: genderValue,
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                            value: 'Female', child: Text('Female')),
                      ],
                      onChanged: (newDropdownValue) => {
                            setState(() {
                              if (newDropdownValue != null) {
                                genderValue = newDropdownValue;
                              }
                            })
                          }),
                ],
              ),
              const Row(
                children: [
                  Text('Patient Problem', style: TextStyle(fontSize: 18)),
                ],
              ),
              TextField(
                maxLines: 10,
                controller: _problemController,
                decoration: const InputDecoration(
                    hintText: 'Write the problem patient is experiencing...',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                maxLines: 10,
                controller: _historyController,
                decoration: const InputDecoration(
                    hintText:
                        'Write prescribed medications and past treatments ...',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  try {
                    final newRequest = <String, String>{
                      "receptionist": FirebaseAuth.instance.currentUser!.email!,
                      "speciality": specialityValue,
                      "patient_name": _nameController.text,
                      "patient_problem": _problemController.text,
                      "patient_number": _numberController.text,
                      "patient_age": _ageController.text,
                      "patient_location": _locationController.text,
                      "patient_gender": genderValue,
                      "patient_history": _historyController.text
                    };
                    await FirebaseFirestore.instance
                        .collection('requests_pending')
                        .add(newRequest);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Transaction Invoice',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat.yMMMd()
                                    .format(DateTime.now())
                                    .toString()),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(DateFormat.jm()
                                    .format(DateTime.now())
                                    .toString()),
                              ],
                            ),
                            const Text(
                              "ID: E2312y4234",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Company Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const Text('PMS'),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('To be Paid by',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(_nameController.text),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Amount to be paid',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const Text("5000"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Fee / Charge',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const Text("No Charge"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Invoice expires on',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            Text(DateFormat.yMMMd()
                                .format(DateTime.now()
                                    .add(const Duration(days: 10)))
                                .toString()),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Patient Request Added')));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(2, 2),
                            color: Color.fromARGB(144, 0, 0, 0),
                            blurRadius: 3)
                      ],
                      color: const Color.fromARGB(255, 113, 184, 241),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
                    'Add Request',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
