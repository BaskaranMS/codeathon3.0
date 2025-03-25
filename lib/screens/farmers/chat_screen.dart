import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animate_do/animate_do.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    fetchChatMessages();
  }

  void fetchChatMessages() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        messages = [
          {
            "sender": "Farmer",
            "message": "Hello! How can I help you?",
            "timestamp": "10:30 AM"
          },
          {
            "sender": "User",
            "message": "I want to know about fresh produce availability.",
            "timestamp": "10:32 AM"
          }
        ];
      });
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isSenderFarmer = message['sender'] == 'Farmer';
                return FadeInUp(
                  duration: Duration(milliseconds: 300),
                  child: Align(
                    alignment:
                        isSenderFarmer ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: isSenderFarmer ? Colors.grey[300] : Colors.green[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['message'],
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              message['timestamp'],
                              style: TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  onPressed: () {},
                  child: Icon(Icons.send, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
