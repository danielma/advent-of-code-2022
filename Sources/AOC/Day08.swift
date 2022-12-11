import Foundation

public struct Day08 {
  public typealias TreeMap = [Point: Int]

  public static func treesVisibleFromOutside(_ input: String) -> Int {
    let map = treeMap(input)
    return visibleFromAnyDirection(map).count
  }

  public static func scenicScore(_ point: Point, _ map: TreeMap) -> Int {
    let treeAtPoint = map[point]!
    let mapMax = map.keys.max()!

    let distances = Compass.allCases.map { dir in
      var treesToConsider: [Int]

      switch dir {
      case .north:
        treesToConsider = Array(stride(from: point.y - 1, to: -1, by: -1))
      case .east:
        treesToConsider = Array(stride(from: point.x + 1, to: mapMax.x + 1, by: 1))
      case .south:
        treesToConsider = Array(stride(from: point.y + 1, to: mapMax.y + 1, by: 1))
      case .west:
        treesToConsider = Array(stride(from: point.x - 1, to: -1, by: -1))
      }

      let lookAxis: Compass = [Compass.west, Compass.east].contains(dir) ? .west : .north

      let blockIndex =
        treesToConsider.firstIndex(where: { axis in
          let treePoint = lookAxis == .west ? Point(axis, point.y) : Point(point.x, axis)
          let tree = map[treePoint]!

          return tree >= treeAtPoint
        })

      if let blockIndex {
        return blockIndex + 1
      } else {
        return treesToConsider.endIndex
      }
    }

    return distances.reduce(1, *)
  }

  public static func optimalSceneicScore(_ map: TreeMap) -> Int {
    return map.keys.map { scenicScore($0, map) }.max()!
  }

  private static func visibleFromAnyDirection(_ map: TreeMap) -> Set<Point> {
    let allDirections = Compass.allCases.map { visibleFrom($0, map) }
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
