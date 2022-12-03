import Foundation

public struct Utils {
  public static func cleanInput(_ input: String) -> String {
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
