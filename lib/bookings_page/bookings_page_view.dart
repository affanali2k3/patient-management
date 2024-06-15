import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:patient_management/bookings_page/bloc/bookings_page_bloc.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  String genderValue = 'Male';
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _locationController = TextEditingController();
  final _problemController = TextEditingController();
  final _historyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Online Booking Form'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
      ),
      body: BlocListener<BookingsPageBloc, BookingsPageState>(
        listener: (context, state) {
          if (state is BookingsPageFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is BookingsPageSuccessState) {
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
                        Text(DateFormat.jm().format(DateTime.now()).toString()),
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
                        .format(DateTime.now().add(const Duration(days: 10)))
                        .toString()),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
            // Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Booking sent')));
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text('Your Name', style: TextStyle(fontSize: 18)),
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
                    Text('Your Number', style: TextStyle(fontSize: 18)),
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
                    Text('Your Age', style: TextStyle(fontSize: 18)),
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
                    Text('Your Location', style: TextStyle(fontSize: 18)),
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
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text('Your Problem', style: TextStyle(fontSize: 18)),
                  ],
                ),
                TextField(
                  maxLines: 10,
                  controller: _problemController,
                  decoration: const InputDecoration(
                      hintText: 'Write the problem you are experiencing...',
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
                  onTap: () {
                    context.read<BookingsPageBloc>().add(BookingSubmitEvent(
                        age: _ageController.text,
                        name: _nameController.text,
                        gender: genderValue,
                        history: _historyController.text,
                        location: _locationController.text,
                        number: _numberController.text,
                        problem: _problemController.text));
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
                        color: const Color.fromARGB(255, 113, 184, 241),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Book Appointment',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
