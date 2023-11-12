import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Position {
  double x = 0;
  double y = 0;
  Position({
    required this.x,
    required this.y,
  });

  Position copyWith({
    double? x,
    double? y,
  }) {
    return Position(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'x': x,
      'y': y,
    };
  }

  factory Position.fromMap(Map<String, dynamic> map) {
    return Position(
      x: map['x'] as double,
      y: map['y'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Position.fromJson(String source) =>
      Position.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Position(x: $x, y: $y)';

  @override
  bool operator ==(covariant Position other) {
    if (identical(this, other)) return true;

    return other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}
