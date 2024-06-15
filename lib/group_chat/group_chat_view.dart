import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_management/colors.dart';

class GroupChatPage extends StatefulWidget {
  const GroupChatPage({super.key, required this.user});

  final Map<String, String> user;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage> {
  List<bool>? appliedList;
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('${widget.user['speciality']} Department Chat'),
        backgroundColor: const Color.fromARGB(255, 113, 184, 241),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      final message = {
                        "department": widget.user['speciality'],
                        "message": _messageController.text,
                        "sender_email": widget.user['email'],
                        "sender_name": widget.user['name'],
                        "timestamp": DateTime.now().millisecondsSinceEpoch
                      };
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .add(message);

                      _messageController.clear();
                    },
                    icon: const Icon(Icons.send)),
                border: const OutlineInputBorder()),
          ),
        ),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.all(10),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where(
                    "department",
                    isEqualTo: widget.user['speciality'],
                  )
                  .orderBy("timestamp", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData) {
                  return const Text("No data available");
                }
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration:
                          const BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 2),
                            blurRadius: 12,
                            color: Color.fromARGB(28, 0, 0, 0))
                      ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. ${messages[index]['sender_name']}",
                            style: const TextStyle(color: CustomColors.primary),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(messages[index]['message']),
                              Row(
                                children: [
                                  Text(
                                    DateFormat(DateFormat.ABBR_MONTH_DAY)
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                messages[index]['timestamp']))
                                        .toString(),
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat(DateFormat.HOUR_MINUTE)
                                        .format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                messages[index]['timestamp']))
                                        .toString(),
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              })),
    );
  }
}
