import Foundation

public struct Day09 {
  struct Move {
    let direction: Compass
    let distance: Int
  }

  enum PlaneObject {
    case ropeHead
    case ropeTail
  }

  class InfinitePlane {
    var map: [[Int]] = []
    var ropeHead: Point
    var ropeTail: Point

    init(ropeHead: Point, ropeTail: Point) {
      self.ropeHead = ropeHead
      self.ropeTail = ropeTail
    }

    convenience init() {
      self.init(ropeHead: Point(0, 0), ropeTail: Point(0, 0))
    }

    public func placeObject(_ object: PlaneObject, _ point: Point) {
      //   if point.y > map.endIndex {
      //     (map.endIndex...point.y).forEach { _ in map.append([]) }
      //   }

      //   var row = map[point.y]

      //   if point.x > row.endIndex {
      //     (row.endIndex...point.x).forEach { _ in row.append([]) }
      //   }
    }

    public func moveRopeHead(_ direction: Compass) {
      ropeHead = ropeHead.move(direction)
    }

    public func placeRopeTail(_ at: Point) {
      ropeTail = at
    }
  }

  private static func debugPrint(_ input: Any) {
    // print(input)
  }

  public static func visitedRopeLocations(_ input: String) -> [Point] {
    let moves = Utils.cleanLines(input).map(parseStep(_:))
    var ropeHead = Point(0, 0)
    var ropeTail = Point(0, 0)
    var ropeTailLocations: [Point] = []

    moves.forEach { move in
      debugPrint(move)

      xTimes(move.distance) {
        ropeHead = ropeHead.move(move.direction)

        ropeTail = tailFollow(head: ropeHead, tail: ropeTail)

        ropeTailLocations.append(ropeTail)

        debugPrint((head: ropeHead, tail: ropeTail))
      }
    }

    return ropeTailLocations
  }

  private static func tailFollow(head: Point, tail: Point) -> Point {
    let diff = head - tail

    var newLocation = tail

    let totalDiff = abs(diff.x) + abs(diff.y)

    if abs(diff.x) > 1 {
      newLocation = newLocation.move(x: diff.x / 2)
    } else if totalDiff > 2 {
      newLocation = newLocation.with(x: head.x)
    }

    if abs(diff.y) > 1 {
      newLocation = newLocation.move(y: diff.y / 2)
    } else if totalDiff > 2 {
      newLocation = newLocation.with(y: head.y)
    }

    return newLocation
  }

  private static func parseStep(_ step: any StringProtocol) -> Move {
    let parts = step.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true)

    let direction = dirToCompass(parts.first!)
    let distance = Int(parts.last!.description)!

    return Move(direction: direction, distance: distance)
  }

  private static func dirToCompass(_ dir: any StringProtocol) -> Compass {
    let dirString = String(dir)
    switch dirString {
    case "R": return .east
    case "U": return .north
    case "L": return .west
    case "D": return .south
    default: fatalError("No drection for \(dirString)")
    }
  }

  private static func xTimes(_ x: Int, action: () -> Void) {
    for _ in 1...x { action() }
  }
}
