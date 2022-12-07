import Foundation

public struct Day06 {
  public static func packetStartIndex(_ input: String) -> Int {
    return findIndexOfUniqChars(input, charCount: 4)
  }

  public static func messageStartIndex(_ input: String) -> Int {
    return findIndexOfUniqChars(input, charCount: 14)
  }

  private static func findIndexOfUniqChars(_ input: String, charCount: Int) -> Int {
    let line = Utils.cleanInput(input)

    for (index, _) in line.enumerated() {
      guard
        index - charCount >= 0,
        let beginIndex = line.index(
          line.startIndex, offsetBy: index - charCount, limitedBy: line.endIndex),
        let endIndex = line.index(
          beginIndex, offsetBy: charCount, limitedBy: line.endIndex)
      else { continue }

      let chars = line[beginIndex..<endIndex]
      let uniqueChars = Set(chars)

      if uniqueChars.count == charCount {
        return index
      }
    }

    return -1
  }
}
