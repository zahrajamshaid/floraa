class GroupModel {
  String groupId;
  String groupName;
  String admin; // UID of the group admin
  List<String> members; // List of member UIDs
  String groupImage;
  String purpose;
  DateTime creationDate;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.admin,
    required this.members,
    required this.groupImage,
    required this.purpose,
    required this.creationDate,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      admin: json['admin'],
      members: List<String>.from(json['members']),
      groupImage: json['groupImage'],
      purpose: json['purpose'],
      creationDate: json['creationDate'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'admin': admin,
      'members': members,
      'groupImage': groupImage,
      'purpose': purpose,
      'creationDate': creationDate,
    };
  }
}
