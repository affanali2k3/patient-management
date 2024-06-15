import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient_management/bookings_page/bookings_page_view.dart';
import 'package:patient_management/colors.dart';
import 'package:patient_management/doctor_page/doctorpage_view.dart';
import 'package:patient_management/login/bloc/login_bloc.dart';
import 'package:patient_management/receptionist_page/receptionistpage_view.dart';
import 'package:patient_management/register/register_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Management System'),
        centerTitle: true,
        // toolbarHeight: kToolbarHeight + 20,
        backgroundColor: CustomColors.primary,
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is LoginSuccessState) {
            if (state.userType == 'Doctor') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorPage(
                      user: state.userData,
                    ),
                  ));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceptionistPage(
                      user: state.userData,
                    ),
                  ));
            }
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login Form',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
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
                      hintText: '********', border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    context.read<LoginBloc>().add(LoginSubmitEvent(
                        email: _emailController.text,
                        password: _passwordController.text));
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
                    child: const Text(
                      'Login',
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
                            builder: (context) => const RegisterPage(),
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
                                  "Don't have an account? "), // First part of the text
                          TextSpan(
                            text:
                                'Register Now', // The part you want to style differently
                            style: TextStyle(
                                color: Color.fromARGB(255, 84, 152,
                                    207)), // Apply different color
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  children: [
                    Text(
                      'For Patients',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingsPage(),
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
                        color: CustomColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Online Booking',
                      style: TextStyle(
                        fontSize: 18,
                      ),
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
