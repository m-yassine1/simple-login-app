class User {
  String access_token;
  int account_type_id;
  int total_active_sessions;
  int account_id;
  int ambassador_id;

  User({this.access_token, this.account_type_id, this.total_active_sessions, this.account_id, this.ambassador_id});

  Map<String, dynamic> toMap() {
    return {
      'access_token': access_token,
      'account_type_id': account_type_id,
      'total_active_sessions': total_active_sessions,
      'account_id': account_id,
      'ambassador_id': ambassador_id,
    };
  }
}

class UserEntity {
  int id;
  String access_token;
  int account_type_id;
  int total_active_sessions;
  int account_id;
  int ambassador_id;

  UserEntity({this.id, this.access_token, this.account_type_id, this.total_active_sessions, this.account_id, this.ambassador_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'access_token': access_token,
      'account_type_id': account_type_id,
      'total_active_sessions': total_active_sessions,
      'account_id': account_id,
      'ambassador_id': ambassador_id,
    };
  }

  User toUser() {
    return User(access_token: access_token, account_type_id: account_type_id, total_active_sessions: total_active_sessions, account_id: account_id, ambassador_id: ambassador_id );
  }

  UserEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    access_token = map['access_token'];
    account_type_id = map['account_type_id'];
    total_active_sessions = map['total_active_sessions'];
    account_id = map['account_id'];
    ambassador_id = map['ambassador_id'];
  }
}