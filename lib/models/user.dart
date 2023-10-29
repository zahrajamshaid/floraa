class UserModel {
  String uid;
  String username;
  String email;
 
  String location;
  String phoneNumber;
  String profilePhoto; 

  UserModel({
    required this.uid,
     required this.username,
    required this.email,

    this.location = "",
    this.phoneNumber="",
    this.profilePhoto="",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      username: json['username'],
      email: json['email'],
      
      location: json['profilePhotoLocation'],
      phoneNumber: json['phoneNumber'],
      profilePhoto: json['profilePhoto'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
     
      'profilePhotoLocation': location,
      'phoneNumber': phoneNumber,
      'profilePhoto': profilePhoto, 
    };
  }
}
