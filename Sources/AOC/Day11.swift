import Foundation

public struct Day11 {
  public static func parseMonkeys(_ input: String) -> [Monkey] {
    let monkeySource = Utils.cleanInput(input).split(separator: "\n\n")

    return monkeySource.map(parseMonkey(_:))
  }

  internal static func parseMonkey<T: StringProtocol>(_ source: T) -> Monkey {
    let lines = source.split(separator: "\n")

    let startItems = lines[1].split(separator: ": ")[1].split(separator: ", ").map {
      Int($0)!
    }
    let operationSource = lines[2].split(separator: ": new = ")[1]
    let operationParts = operationSource.split(separator: " ")
    let operation: MonkeyOperation = {
      if operationParts[1] == "+" {
        return .plus(Int(operationParts[2])!)
      } else if operationParts[1] == "*" {
        if operationParts[0] == "old" && operationParts[2] == "old" {
          return .squared
        } else {
          return .multiplied(by: Int(operationParts[2])!)
        }
      } else {
        fatalError("Couldn't parse operation \(operationParts)")
      }
    }()

    let testDivisor = Int(lines[3].split(separator: ": divisible by ")[1])!
    let testTrueMonkey = Int(lines[4].split(separator: ": throw to monkey ")[1])!
    let testFalseMonkey = Int(lines[5].split(separator: ": throw to monkey ")[1])!

    let throwDestination = { (value: Int) in
      value % testDivisor == 0 ? testTrueMonkey : testFalseMonkey
    }

    return Monkey(items: startItems, operation: operation, throwDestination: throwDestination)
  }

  public struct Monkey {
    public var items: [Int]
    public let operation: MonkeyOperation
    public let throwDestination: (Int) -> Int

    public var totalInspected = 0
  }

  public enum MonkeyOperation {
    case multiplied(by: Int)
    case plus(_ adder: Int)
    case squared
  }

  public static func doARound(_ incomingMonkeys: [Monkey]) -> [Monkey] {
    var monkeys = incomingMonkeys

    for index in monkeys.indices {
      let monkey = monkeys[index]
      for item in monkey.items {
        let nextWorry = Day11.performOperation(monkey.operation, old: item)
        let reducedWorry = Int(floor(Double(nextWorry) / 3))
        let throwDest = monkey.throwDestination(reducedWorry)

        monkeys[index].totalInspected += 1
        monkeys[throwDest].items.append(reducedWorry)
      }

      monkeys[index].items = []
    }

    return monkeys
  }

  public static func performOperation(_ operation: MonkeyOperation, old: Int) -> Int {
    switch operation {
    case .multiplied(by: let mult):
      return old * mult
    case .plus(let adder):
      return old + adder
    case .squared:
      return old * old
    }
  }

  private static func chunkArray<E>(_ arr: [E], into size: Int) -> [[E]] {
    return stride(from: 0, to: arr.count, by: size).map {
      Array(arr[$0..<min($0 + size, arr.count)])
    }
  }
}
