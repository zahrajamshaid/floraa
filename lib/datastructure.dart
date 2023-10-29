
// users (collection)
//   - user_id_1 (document)
//     - uid: "user_id_1"
//     - username: "User1"
//     - email: "user1@example.com"
//     - password: "password123"
//     - groups (subcollection)
//       - group_id_1 (document)
//         - role: "admin"
//       - group_id_2 (document)
//         - role: "member"
//       // Other groups...

// groups (collection)
//   - default_group_id (document)
//     - groupName: "Flora Enthusiast"
//     - admin: null
//     - members (subcollection)
//       - user_id_1 (document)
//       - // Other members...
//     - groupImage: "URL_to_image"
//     - purpose: "Discussing flora and plants"
//     - creationDate: October 22, 2023

// messages (collection)
//   - group_id_1 (document) // Each group has its own collection
//     - message_id_1 (document)
//       - senderUsername: "User1"
//       - text: "Hello, how's everyone?"
//       - timestamp: Firebase Firestore Timestamp
//       - messageType: "sent"
//     - message_id_2 (document)
//       - senderUsername: "User2"
//       - text: "We have a beautiful garden!"
//       - timestamp: Firebase Firestore Timestamp
//       - messageType: "received"
//     // Other messages...
//   - group_id_2 (document)
//     // Messages for other groups...
// //