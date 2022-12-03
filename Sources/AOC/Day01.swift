import Foundation

public struct Day01 {
  public static func mostCalories(_ input: String) -> Int {
    let elves = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n\n")
    let calories = elves.map { elf in
      let numbers = elf.components(separatedBy: "\n").map { Int($0)! }
      
      return numbers.reduce(0, +)
    }
    
    let highest = calories.sorted().last!
    
    return highest
  }
}
