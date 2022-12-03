import Foundation

public struct Day01 {
  public static func mostCalories(_ input: String, sumOf: Int = 1) -> Int {
    let elves = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n\n")
    let calories = elves.map { elf in
      let numbers = elf.components(separatedBy: "\n").map { Int($0)! }
      
      return numbers.reduce(0, +)
    }
    
    let highest = calories.sorted().suffix(sumOf).reduce(0, +)
    
    return highest
  }
  
  public static func topThreeCalories(_ input: String) -> Int {
    return mostCalories(input, sumOf: 3)
  }
}
