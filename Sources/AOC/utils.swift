import Foundation

public struct Utils {
  public static func cleanInput(_ input: String) -> String {
    return input.trimmingCharacters(in: .newlines)
  }

  public static func cleanLines(_ input: String) -> [Substring] {
    return cleanInput(input).split(separator: "\n")
  }

  public static func chunkArray<T>(_ arr: [T], groupsOf: Int) -> [[T]] {
    var out: [[T]] = []

    for index in stride(from: arr.startIndex, to: arr.endIndex, by: groupsOf) {
      let endIndex = index + groupsOf > arr.endIndex ? arr.endIndex : index + groupsOf
      let chunk = Array(arr[index..<endIndex])

      out.append(chunk)
    }

    return out
  }

}

public protocol ReflectedStringConvertible: CustomStringConvertible {}

extension ReflectedStringConvertible {
  public var description: String {
    let mirror = Mirror(reflecting: self)

    var str = "\(mirror.subjectType)("
    var first = true
    for (label, value) in mirror.children {
      if let label = label {
        if first {
          first = false
        } else {
          str += ", "
        }
        str += label
        str += ": "
        str += "\(value)"
      }
    }
    str += ")"

    return str
  }
}

extension Int {
  func times(action: (Int) -> Void) {
    for time in 1...self {
      action(time)
    }
  }
}
