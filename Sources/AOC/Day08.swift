import Foundation

public struct Day08 {
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

    public static func < (lhs: Point, rhs: Point) -> Bool {
      if lhs.y != rhs.y { return lhs.y < rhs.y } else { return lhs.x < rhs.x }
    }
  }

  public typealias TreeMap = [Point: Int]

  public enum Compass: CaseIterable {
    case north
    case east
    case south
    case west
  }

  public static func treesVisibleFromOutside(_ input: String) -> Int {
    let map = treeMap(input)
    return visibleFromAnyDirection(map).count
  }

  private static func visibleFromAnyDirection(_ map: TreeMap) -> Set<Point> {
    let allDirections = Compass.allCases.map { visibleFrom($0, map) }
    // Compass.allCases.forEach { dir in
    //   print(dir)
    //   let vis = visibleFrom(dir, map).sorted()
    //   print("I count \(vis.count)")
    //   print(vis)
    // }
    return Set(allDirections.joined())
  }

  public static func treeMap(_ input: String) -> TreeMap {
    let lines = Utils.cleanLines(input)

    var map: TreeMap = [:]

    for (lineIndex, line) in lines.enumerated() {
      for (charIndex, char) in line.enumerated() {
        map[Point(charIndex, lineIndex)] = char.wholeNumberValue
      }
    }

    return map
  }

  public static func visibleFrom(_ direction: Compass, _ treeMap: TreeMap) -> [Point] {
    guard let maxPoint = treeMap.keys.max() else {
      fatalError("Couldn't find maxPoint")
    }

    let mapWidth = maxPoint.x
    let mapHeight = maxPoint.y

    var visible: [Point] = []

    let lookAxis: Compass = [Compass.west, Compass.east].contains(direction) ? .west : .north

    for point in treeMap.keys {
      let treeAtPoint = treeMap[point]!

      let hidePoints: any Sequence<Int> = {
        switch direction {
        case .north:
          return 0..<point.y
        case .east:
          if point.x < mapWidth {
            return stride(from: mapWidth, to: point.x, by: -1)
          } else {
            return []
          }
        case .south:
          if point.y < mapHeight {
            return stride(from: mapHeight, to: point.y, by: -1)
          } else {
            return []
          }
        case .west:
          return 0..<point.x
        }
      }()

      let hidden = hidePoints.contains { outwardCoord in
        let outwardPoint =
          lookAxis == .west ? Point(outwardCoord, point.y) : Point(point.x, outwardCoord)
        let outwardTree = treeMap[outwardPoint]!

        return outwardTree >= treeAtPoint
      }

      if !hidden { visible.append(point) }
    }

    return visible
  }
}
