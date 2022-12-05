import Foundation

public struct Day05 {
  static let boxWidth = 3

  // top to bottom, like you're looking at them (cons operations)
  typealias BoxColumn = [Character]

  struct MoveInstruction {
    let count: Int

    let fromColumn: Int
    let toColumn: Int
  }

  public static func execute9000Moves(_ input: String) -> [[Character]] {
    let lines = Utils.cleanLines(input)

    let firstMoveIndex = lines.firstIndex { $0.starts(with: "move") }!

    let boxLines = lines.prefix(firstMoveIndex - 1)
    let boxColumns = buildBoxColumns(boxLines)

    // print(boxColumns)

    let moveLines = lines.dropFirst(firstMoveIndex)
    let moves = parseMoves(moveLines)
    // print(moves)

    return moves.reduce(boxColumns) { (columns, move) in execute9000(move, on: columns) }
  }

  public static func execute9001Moves(_ input: String) -> [[Character]] {
    let lines = Utils.cleanLines(input)

    let firstMoveIndex = lines.firstIndex { $0.starts(with: "move") }!

    let boxLines = lines.prefix(firstMoveIndex - 1)
    let boxColumns = buildBoxColumns(boxLines)

    let moveLines = lines.dropFirst(firstMoveIndex)
    let moves = parseMoves(moveLines)

    return moves.reduce(boxColumns) { (columns, move) in execute9001(move, on: columns) }
  }

  private static func execute9000(_ move: MoveInstruction, on boxColumns: [BoxColumn])
    -> [BoxColumn]
  {
    var newColumns = boxColumns

    for _ in 1...move.count {
      let mover = newColumns[move.fromColumn - 1].removeFirst()
      newColumns[move.toColumn - 1].insert(mover, at: 0)
    }

    return newColumns
  }

  private static func execute9001(_ move: MoveInstruction, on boxColumns: [BoxColumn])
    -> [BoxColumn]
  {
    var newColumns = boxColumns

    var movers: [Character] = []
    for _ in 1...move.count {
      movers.append(newColumns[move.fromColumn - 1].removeFirst())
    }
    newColumns[move.toColumn - 1].insert(contentsOf: movers, at: 0)

    return newColumns
  }

  private static func lineToBoxNames(_ line: any StringProtocol) -> [Character] {
    let chunks = Utils.chunkArray(Array(line), groupsOf: boxWidth + 1)

    // chunk = ["[", "N", "]", " "]
    return chunks.map { $0[1] }
  }

  private static func buildBoxColumns(_ boxLines: Array<Substring>.SubSequence) -> [BoxColumn] {
    var boxColumns: [BoxColumn] = []

    let bottomRowOfBoxes = boxLines.last!
    lineToBoxNames(bottomRowOfBoxes).forEach { _ in boxColumns.append(BoxColumn()) }

    boxLines.forEach { line in
      let boxNames = lineToBoxNames(line)

      for (index, name) in boxNames.enumerated() {
        if name != " " {
          boxColumns[index].append(name)
        }
      }
    }

    return boxColumns
  }

  private static func parseMoves(_ moveLines: Array<Substring>.SubSequence) -> [MoveInstruction] {
    // line = "move 1 from 2 to 1"
    let matcher = #/move (?<count>\d+) from (?<fromColumn>\d+) to (?<toColumn>\d+)/#

    return moveLines.map { line in
      let match = line.firstMatch(of: matcher)!

      return MoveInstruction(
        count: Int(match.count)!,
        fromColumn: Int(match.fromColumn)!,
        toColumn: Int(match.toColumn)!
      )
    }
  }
}
