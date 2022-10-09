class User {
  final String accessToken;
  final String userID;

  User(this.accessToken, this.userID);

  User.fromJson(Map<String, dynamic> json)
      : accessToken = json['accesstoken'],
        userID = json['userid'];

  Map<String, dynamic> toJson() => {
        'accesstoken': accessToken,
        'userid': userID,
      };
}