class Alarm {
  final int? id;
  final bool isOn;
  final DateTime remindTime;
  final String weekID;
  const Alarm({
    this.id,
    required this.weekID,
    required this.isOn,
    required this.remindTime,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'isOn': isOn ? 1 : 0,
      'weekID': weekID,
      'remindTime': remindTime.toIso8601String(),
    };
  }

  static Alarm fromJson(Map<String, Object?> json) => Alarm(
        id: json['_id'] as int,
        isOn: json['isOn'] == 1,
        weekID: json['weekID'] as String,
        remindTime: DateTime.parse(json['remindTime'] as String),
      );
}

class RepateArlam {
  final int? id;
  final String weekID;
  final int setOrder;
  final String week;

  const RepateArlam(
      {this.id,
      required this.setOrder,
      required this.weekID,
      required this.week});

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'week': week,
      'weekID': weekID,
      'setOrder': setOrder,
    };
  }

  static RepateArlam fromJson(Map<String, Object?> json) => RepateArlam(
        id: json['_id'] as int,
        setOrder: json['setOrder'] as int,
        week: json['week'] as String,
        weekID: json['weekID'] as String,
      );
}
