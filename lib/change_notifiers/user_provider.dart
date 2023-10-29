import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flora/models/user.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _username = ''; // Add a property to store the username

  String get username => _username;
  User? _user;
  bool get isLoggedIn => _user != null;
Future<bool> attemptAutomaticLogin() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // User is already authenticated, fetch their username and store it.
        _user = user;
        await fetchUsername();
        return true; // Successful automatic login
      }
      return false; // No user to automatically log in
    } catch (error) {
      // Handle any errors that occur during automatic login
      return false;
    }
  }
  Future<bool> login(String email, String password) async {
    
      

    try {
    
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if the user's email and password exist in Firestore
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      final QuerySnapshot querySnapshot = await usersCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
      
          .get();

      // If a document with matching email and password is found, consider it a successful login
      if (querySnapshot.docs.isNotEmpty) {
        _user = userCredential.user;
        fetchUsername(); // Fetch the username after login
        return true;
      } else {
        // If no matching document is found, log out the user
        await FirebaseAuth.instance.signOut();
        _user = null;
        return false;
      }
    } catch (error) {
      // Handle login errors and return false
      return false;
    }
  }

  // Add a logout method
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
  }

  Future<String?> getCurrentUserUid() async {
    if (_user != null) {
      return _user!.uid;
    } else {
      return null;
    }
  }

  Future<void> fetchUsername() async {
    try {
      if (_user != null) {
        // If a user is logged in, you can use their UID to fetch the username
        final uid = _user!.uid;

        // Replace 'users' with the actual collection name where usernames are stored
        final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

        final DocumentSnapshot userDoc = await usersCollection.doc(uid).get();

        if (userDoc.exists) {
          // Check if 'username' exists in the data before accessing it
          final Map<String, dynamic>? usernameData = userDoc.data() as Map<String, dynamic>?;
          if (usernameData != null) {
            _username = usernameData['username'] ?? 'DefaultUsername'; // Set a default username
          } else {
            _username = 'DefaultUsername'; // Set a default username
          }
        }
      }
    } catch (error) {
      // Handle any errors that occur during username fetching
    }
  }

  Future<void> updateUserInfo(UserModel user) async {
    try {
      final currentUserUid = await getCurrentUserUid();
      if (currentUserUid != null) {
        final userCollection = FirebaseFirestore.instance.collection('users');

        await userCollection.doc(currentUserUid).update({
          'username': user.username,
          'email': user.email,
          'location': user.location,
          'phoneNumber': user.phoneNumber,
          'profilePhoto': user.profilePhoto,
        });

        // Update the local username property
        _username = user.username;

        notifyListeners();
      }
    } catch (error) {
      // Handle any errors that occur during user information update
    }
  }

  Stream<List<UserModel>> getAllUsers() {
    final userCollection = FirebaseFirestore.instance.collection('users');
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel(
          uid: doc.id,
          username: doc['username'],
          email: doc['email'],
          location: doc['profilePhotoLocation'],
          phoneNumber: doc['phoneNumber'],
          profilePhoto: doc['profilePhoto'],
        );
      }).toList();
    });
  }
Future<UserModel?> getCurrentUserData() async {
  try {
    final currentUserUid = await getCurrentUserUid();
    if (currentUserUid != null) {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final DocumentSnapshot userDoc = await userCollection.doc(currentUserUid).get();

      if (userDoc.exists) {
        final Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null) {
          final UserModel currentUser = UserModel(
            uid: userDoc.id,
            username: userData['username'] ?? 'DefaultUsername',
            email: userData['email'] ?? 'DefaultEmail',
            location: userData['location'] ?? 'DefaultLocation',
            phoneNumber: userData['phoneNumber'] ?? 'DefaultPhoneNumber',
            profilePhoto: userData['profilePhoto'] ?? 'DefaultProfilePhoto',
          );
          return currentUser;
        }
      }
    }
    return null; // User data not found
  } catch (error) {
    // Handle any errors that occur during user data fetching
    return null;
  }
}


}