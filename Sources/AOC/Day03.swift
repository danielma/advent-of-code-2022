import Foundation

struct Sack {
  let left: String
  let right: String
  let full: String

  init(fromString string: String) {
    let index = string.index(string.startIndex, offsetBy: (string.count / 2))

    left = String(string[..<index])
    right = String(string[index...])
    full = string
  }

  var intersection: Set<Character> {
    return Set(left).intersection(right)
  }
}

private func chunkArray<T>(_ arr: [T], groupsOf: Int) -> [[T]] {
  var out: [[T]] = []

  for index in stride(from: 0, to: arr.count, by: 3) {
    let endIndex = index + 3
    let chunk = Array(arr[index..<endIndex])

    out.append(chunk)
  }

  return out
}

public struct Day03 {
  public static func prioritiesSum(_ input: String) -> Int {
    let sacks = Utils.cleanInput(input).split(separator: "\n").map { Sack(fromString: String($0)) }

    let priorities = sacks.map { s in characterPriority(s.intersection.first!) }

    return priorities.reduce(0, +)
  }

  public static func groupPrioritiesSum(_ input: String) -> Int {
    let lines = Utils.cleanInput(input).split(separator: "\n")
    let groupsOfThree = chunkArray(lines, groupsOf: 3)

    let commonLetters = groupsOfThree.map { group in
      group.reduce(Set(group.first!)) { $0.intersection($1) }
    }

    return commonLetters.reduce(0) { $0 + characterPriority($1.first!) }
  }

  static let range = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

  private static func characterPriority(_ char: Character) -> Int {
    let index = range.firstIndex(of: char)!
    let priority = range.distance(from: range.startIndex, to: index)
    return priority + 1
  }
}
