class User {
  final String userId;
  final String displayName;
  final String email;
  final String phoneNumber;

  User({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'],
      displayName: map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
