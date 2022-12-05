import Foundation

@available(macOS 13.0, *)
public struct Day04 {
  public static func fullSubsetPairs(_ input: String) -> Int {
    let rangePairs = Utils.cleanInput(input).split(separator: "\n").map { line in
      let (leftElf, rightElf) = halfSplit(line)

      return (left: parseRange(leftElf), right: parseRange(rightElf))
    }

    return rangePairs.filter { (left, right) in
      left.contains(right) || right.contains(left)
    }.count
  }

  private static func parseRange(_ input: any StringProtocol) -> ClosedRange<Int> {
    let (left, right) = halfSplit(input, by: "-")
    let startIndex = Int(String(left))!
    let endIndex = Int(String(right))!

    return startIndex...endIndex
  }

  private static func halfSplit<S: StringProtocol>(_ input: S, by: Character = ",") -> (
    S.SubSequence, S.SubSequence
  ) {
    let split = input.split(separator: by)
    return (split[0], split[1])
  }
}
