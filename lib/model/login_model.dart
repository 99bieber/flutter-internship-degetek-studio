class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({this.token, this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }

  Object toJson() {}
}

class LoginRequestModel {
  String user;
  String password;

  LoginRequestModel({
    this.user,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user': user.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

// class coba {
//   String token;
//   Posts3 posts3;

//   coba(this.token, this.posts3);
//   factory coba.fromJson(dynamic json){
//     return coba(

//     );
//   }
// }

// class Posts3 {}
