public struct Point: Hashable, CustomStringConvertible, Comparable {
  let x: Int
  let y: Int

  public init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }

  public init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }

  public var description: String {
    return "(x: \(x), y: \(y))"
  }

  public func with(x: Int) -> Point {
    return Point(x, y)
  }

  public func with(y: Int) -> Point {
    return Point(x, y)
  }

  public func move(x: Int) -> Point {
    return Point(x + self.x, y)
  }

  public func move(y: Int) -> Point {
    return Point(x, y + self.y)
  }

  public func move(_ dir: Compass) -> Point {
    switch dir {
    case .east: return with(x: x + 1)
    case .south: return with(y: y + 1)
    case .west: return with(x: x - 1)
    case .north: return with(y: y - 1)
    }
  }

  public static func < (lhs: Point, rhs: Point) -> Bool {
    if lhs.y != rhs.y { return lhs.y < rhs.y } else { return lhs.x < rhs.x }
  }

  public static func - (lhs: Point, rhs: Point) -> Point {
    return Point(lhs.x - rhs.x, lhs.y - rhs.y)
  }
}

public enum Compass: CaseIterable {
  case north
  case east
  case south
  case west
}
