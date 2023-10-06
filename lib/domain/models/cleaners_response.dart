class CleanersResponse {
  int? id;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? block;


  CleanersResponse(
      {this.id, this.name, this.email, this.role, this.phone, this.block});

  CleanersResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    phone = json['phone'];
    block = json['block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['role'] = this.role;
    data['phone'] = this.phone;
    data['block'] = this.block;
    return data;
  }
}
