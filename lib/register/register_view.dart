import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_management/colors.dart';
import 'package:patient_management/login/login_view.dart';
import 'package:patient_management/register/bloc/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String jobTypeValue = 'Doctor';
  String specialityValue = 'Surgeon';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Management System'),
        centerTitle: true,
        // toolbarHeight: kToolbarHeight + 20,
        backgroundColor: CustomColors.primary,
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Registration succesful. You may login now')));
          } else if (state is RegisterFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            setState(() {
              loading = false;
            });
          }
        },
        child: SafeArea(
          minimum: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Registration Form',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontSize: 18),
                    ),
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
                    Text(
                      'Email',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: 'email@address.com',
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: '******', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Job Type', style: TextStyle(fontSize: 18)),
                    DropdownButton(
                        value: jobTypeValue,
                        items: const [
                          DropdownMenuItem(
                              value: 'Doctor', child: Text('Doctor')),
                          DropdownMenuItem(
                              value: 'Receptionist',
                              child: Text('Receptionist'))
                        ],
                        onChanged: (newDropdownValue) => {
                              setState(() {
                                if (newDropdownValue != null) {
                                  jobTypeValue = newDropdownValue;
                                }
                              })
                            }),
                  ],
                ),
                jobTypeValue == 'Doctor'
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Speciality',
                              style: TextStyle(fontSize: 18)),
                          DropdownButton(
                              value: specialityValue,
                              items: const [
                                DropdownMenuItem(
                                    value: 'Eye', child: Text('Eye')),
                                DropdownMenuItem(
                                    value: 'ENT', child: Text('ENT')),
                                DropdownMenuItem(
                                    value: 'Neuro', child: Text('Neuro')),
                                DropdownMenuItem(
                                    value: 'Surgeon', child: Text('Surgeon')),
                                DropdownMenuItem(
                                    value: 'Cardiology',
                                    child: Text('Cardiology')),
                                DropdownMenuItem(
                                    value: 'Dermatology',
                                    child: Text('Dermatology')),
                                DropdownMenuItem(
                                    value: 'Gastroenterology',
                                    child: Text('Gastroenterology')),
                                DropdownMenuItem(
                                    value: 'Pediatrics',
                                    child: Text('Pediatrics')),
                                DropdownMenuItem(
                                    value: 'Orthopedics',
                                    child: Text('Orthopedics')),
                                DropdownMenuItem(
                                    value: 'Urology', child: Text('Urology')),
                                DropdownMenuItem(
                                    value: 'Psychiatry',
                                    child: Text('Psychiatry')),
                                DropdownMenuItem(
                                    value: 'Oncology', child: Text('Oncology')),
                                DropdownMenuItem(
                                    value: 'Gynecology',
                                    child: Text('Gynecology')),
                                DropdownMenuItem(
                                    value: 'Neurology',
                                    child: Text('Neurology')),
                                DropdownMenuItem(
                                    value: 'Radiology',
                                    child: Text('Radiology')),
                                DropdownMenuItem(
                                    value: 'Endocrinology',
                                    child: Text('Endocrinology')),
                                DropdownMenuItem(
                                    value: 'Pulmonology',
                                    child: Text('Pulmonology')),
                              ],
                              onChanged: (newDropdownValue) => {
                                    setState(() {
                                      if (newDropdownValue != null) {
                                        specialityValue = newDropdownValue;
                                      }
                                    })
                                  }),
                        ],
                      )
                    : const SizedBox(),
                InkWell(
                  onTap: () async {
                    context.read<RegisterBloc>().add(RegisterSubmitEvent(
                        email: _emailController.text,
                        password: _passwordController.text,
                        jobType: jobTypeValue,
                        name: _nameController.text));
                    setState(() {
                      loading = true;
                    });
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
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          // Default text style for all spans
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "Already have an account? "), // First part of the text
                          TextSpan(
                            text:
                                'Login Now', // The part you want to style differently
                            style: TextStyle(
                                color: Color.fromARGB(255, 84, 152,
                                    207)), // Apply different color
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
