class Point2D {
  double x;
  double y;

  Point2D(this.x, this.y);

  @override
  String toString() {
    return 'Point2D{x: $x, y: $y}';
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Point2D && other.x == x && other.y == y;
  }

  bool operator <(Object other) {
    if (identical(this, other)) return false;
    if (other is! Point2D) return false;
    final otherPoint = other;
    return x < otherPoint.x && y < otherPoint.y;
  }

  bool operator >(Object other) {
    if (identical(this, other)) return false;
    if (other is! Point2D) return false;
    final otherPoint = other;
    return x > otherPoint.x && y > otherPoint.y;
  }

  bool operator <=(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point2D) return false;
    final otherPoint = other;
    return x <= otherPoint.x && y <= otherPoint.y;
  }

  bool operator >=(Object other) {
    if (identical(this, other)) return true;
    if (other is! Point2D) return false;
    final otherPoint = other;
    return x >= otherPoint.x && y >= otherPoint.y;
  }

  Point2D operator +(Point2D other) {
    return Point2D(x + other.x, y + other.y);
  }

  Point2D operator -(Point2D other) {
    return Point2D(x - other.x, y - other.y);
  }
}