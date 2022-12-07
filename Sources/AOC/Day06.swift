import Foundation

public struct Day06 {
  static let messageWidth = 4
  public static func packetStartIndex(_ input: String) -> Int {
    let line = Utils.cleanInput(input)

    for (index, _) in line.enumerated() {
      guard
        index - messageWidth >= 0,
        let beginIndex = line.index(
          line.startIndex, offsetBy: index - messageWidth, limitedBy: line.endIndex),
        let endIndex = line.index(
          beginIndex, offsetBy: messageWidth, limitedBy: line.endIndex)
      else { continue }

      let chars = line[beginIndex..<endIndex]
      let uniqueChars = Set(chars)

      if uniqueChars.count == messageWidth {
        return index
      }
    }

    return -1
  }
}
