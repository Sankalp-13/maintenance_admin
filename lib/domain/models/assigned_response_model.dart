class AssignedJobResponse {
  int? id;
  String? time;
  Room? room;
  Staff? staff;

  AssignedJobResponse({this.id, this.time, this.room, this.staff});

  AssignedJobResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    room = json['Room'] != null ? new Room.fromJson(json['Room']) : null;
    staff = json['Staff'] != null ? new Staff.fromJson(json['Staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    if (this.room != null) {
      data['Room'] = this.room!.toJson();
    }
    if (this.staff != null) {
      data['Staff'] = this.staff!.toJson();
    }
    return data;
  }
}

class Room {
  int? number;
  String? block;

  Room({this.number, this.block});

  Room.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    block = json['block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['block'] = this.block;
    return data;
  }
}

class Staff {
  String? name;

  Staff({this.name});

  Staff.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
