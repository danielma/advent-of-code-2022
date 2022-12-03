import Foundation

struct Sack {
  let left: String
  let right: String

  init(fromString string: String) {
    let index = string.index(string.startIndex, offsetBy: (string.count / 2))

    left = String(string[..<index])
    right = String(string[index...])
  }

  var intersection: Set<Character> {
    return Set(left).intersection(right)
  }
}

public struct Day03 {
  public static func prioritiesSum(_ input: String) -> Int {
    let sacks = Utils.cleanInput(input).split(separator: "\n").map { Sack(fromString: String($0)) }

    let priorities = sacks.map { s in characterPriority(s.intersection.first!) }

    return priorities.reduce(0, +)
  }

  static let range = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  private static func characterPriority(_ char: Character) -> Int {
    let index = range.firstIndex(of: char)!
    let priority = range.distance(from: range.startIndex, to: index)
    return priority + 1
  }
}
