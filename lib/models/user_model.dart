class UserModel {
  int? id;
  String? email;
  String? name;
  String? role;

  UserModel({this.id, this.email, this.name, this.role});

  // Factory constructor for creating a UserModel instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }

  // Method to convert a UserModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
    };
  }
}
