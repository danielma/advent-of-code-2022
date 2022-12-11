import Foundation

public struct Day09 {
  struct Move {
    let direction: Compass
    let distance: Int
  }

  public class Rope {
    var locations: [Point]

    public init(length: Int) {
      self.locations = Array.init(repeating: Point(0, 0), count: length)
    }
  }

  private static func debugPrint(_ input: Any) {
    // print(input)
  }

  public static func visitedTailLocations(_ input: String, rope: Rope) -> [Point] {
    let moves = Utils.cleanLines(input).map(parseStep(_:))
    var ropeTailLocations: [Point] = []

    moves.forEach { move in
      debugPrint(move)

      xTimes(move.distance) {
        for (index, location) in rope.locations.enumerated() {
          if index == 0 {
            rope.locations[index] = rope.locations[index].move(move.direction)
          } else {
            rope.locations[index] = tailFollow(
              head: rope.locations[index - 1], tail: rope.locations[index])
          }

          debugPrint(rope.locations)
        }

        ropeTailLocations.append(rope.locations.last!)

        // debugPrint((head: ropeHead, tail: ropeTail))
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
