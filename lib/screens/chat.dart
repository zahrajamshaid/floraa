import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flora/theme.dart';

class ChatScreen extends StatelessWidget {
    TextStyle groupNameTextStyle = TextStyle(
    color: Color(0xFF2C2015).withOpacity(1.0), // Fully opaque
    fontSize: 14, // 14px
    fontWeight: FontWeight.w400, // font-weight: 400
    fontFamily: 'Dosis',
  );

  TextStyle totalMembersTextStyle = TextStyle(
    color: AppColors.totalMembersColor,
    fontSize: 12, // 12px
    fontWeight: FontWeight.w400, // font-weight: 400
    fontFamily: 'Dosis',
  );

  TextStyle leaveButtonTextStyle = TextStyle(
    color: AppColors.leaveButtonColor,
    // textAlign: TextAlign.center, // text-align: center
    fontSize: 14, // 14px
    fontWeight: FontWeight.w400, // font-weight: 400
    fontFamily: 'Dosis',
  );

  TextStyle usernameTextStyle = TextStyle(
    color: AppColors.usernameColor,
    fontSize: 10, // 10px
    fontWeight: FontWeight.w500, // font-weight: 500
    fontFamily: 'Dosis',
  );

  TextStyle messageTextStyle = TextStyle(
    color: AppColors.messageTextColor,
    fontSize: 12, // 12px
    fontWeight: FontWeight.w400, // font-weight: 400
    fontFamily: 'Dosis',
  );

  TextStyle dateTextStyle = TextStyle(
    color: AppColors.dateColor,
    fontSize: 10, // 10px
    fontWeight: FontWeight.w400, // font-weight: 400
    fontFamily: 'Inter',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.white,
  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Group Name',
        style: groupNameTextStyle,
      ),
      Text(
        'Total Members: 10', // Replace with actual member count
        style: totalMembersTextStyle,
      ),
    ],
  ),
  leading: IconButton(
    color: Colors.black,
    icon: Icon(Icons.arrow_back),
    onPressed: () {
        Navigator.of(context).pop();
      // Handle back button action
    },
  ),
  actions: <Widget>[
    TextButton(
      onPressed: () {
        // Handle leave group action
      },
      child: Text(
        'Leave',
        style: leaveButtonTextStyle,
      ),
    ),
  ],
),

      body: Column(
        children: <Widget>[
          // Date at the top
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: dateTextStyle,
            ),
          ),
          // Message List
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                _buildMessage(
                  'John Doe',
                  'Hello, how are you today?',
                  '9:30 AM',
                  false,
                ),
                _buildMessage(
                  'John Doe',
                  'Hello, how are you today?',
                  '9:30 AM',
                  true,
                ),
                 _buildMessage(
                  'John Doe',
                  'Hello, how are you today?',
                  '9:30 AM',
                  false,
                ),
                 _buildMessage(
                  'John Doe',
                  'Hello, how are you today?',
                  '9:30 AM',
                  false,
                ),
              
                // Add more message widgets here for the chat history
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildSendingMessageBar(),
    );
  }
  Widget _buildMessage(
    String username,
    String message,
    String messageDate,
    bool isSentByUser,
  ) {
    final messageAlignment = isSentByUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = Colors.white;

    return Row(
      mainAxisAlignment: isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: isSentByUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(0),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(67, 78, 110, 0.50),
                offset: Offset(0, 4),
                blurRadius: 4,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: messageAlignment,
            children: <Widget>[
              Text(
                username,
                style: usernameTextStyle,
              ),
              Text(
                message,
                style: messageTextStyle,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  messageDate,
                  style: dateTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
Widget _buildSendingMessageBar() {
  return  Padding(
    padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
     
            SvgPicture.asset(
              'lib/assets/add.svg', // Replace with your SVG asset
              color: Colors.black,
              width: 40, // Set the width for the "Add" SVG
              height: 40, // Set the height for the "Add" SVG
            ),
   
          Expanded(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8),
               decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(149, 135, 122, 0.15), ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                         border: InputBorder.none,
                      
                      ),
                      
                    ),
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'lib/assets/send.svg', // Replace with your SVG asset
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Handle send action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
  );
}
}