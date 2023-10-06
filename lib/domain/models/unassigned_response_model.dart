class UnassignedJobsResponse {
  int? id;
  String? time;
  Room? room;
  int? assignedCleanerIndex;

  UnassignedJobsResponse({this.id, this.time, this.room});

  UnassignedJobsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    room = json['Room'] != null ? new Room.fromJson(json['Room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    if (this.room != null) {
      data['Room'] = this.room!.toJson();
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
