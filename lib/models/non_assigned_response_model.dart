import 'dart:convert';

// NonAssignedJobs  nonAssignedJobs(String str) =>
//     NonAssignedJobs.fromJson(json.decode(str));


List<NonAssignedJobs>  nonAssignedJobs(String str) {
  List<dynamic> jsonList = json.decode(str);
  List<NonAssignedJobs> personList = jsonList.map((json) => NonAssignedJobs.fromJson(json)).toList();
  return personList;
}
//
//
// final List t = json.decode(response.body);
// final List<NonAssignedJobs> portasAbertasList =
// t.map((item) => NonAssignedJobs.fromJson(item)).toList();

class NonAssignedJobs {
  late final  int? id;
  late final String? time;
  late final Room? room;

  NonAssignedJobs({required this.id,required this.time,required this.room});

  NonAssignedJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    room = json['Room'] != null ? Room.fromJson(json['Room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['time'] = time;
    if (room != null) {
      data['Room'] = room!.toJson();
    }
    return data;
  }
}

class Room {
  int? number;

  Room({this.number});

  Room.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    return data;
  }
}
