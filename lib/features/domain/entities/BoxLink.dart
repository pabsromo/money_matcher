import 'package:flutter/material.dart';

class BoxLink {
  final Offset start;
  final Offset end;

  BoxLink({required this.start, required this.end});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BoxLink &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
