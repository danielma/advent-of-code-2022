import BigInt
import Foundation

public struct Day11 {
  public static func parseMonkeys(_ input: String) -> [Monkey] {
    let monkeySource = Utils.cleanInput(input).split(separator: "\n\n")

    return monkeySource.map(parseMonkey(_:))
  }

  internal static func parseMonkey<T: StringProtocol>(_ source: T) -> Monkey {
    let lines = source.split(separator: "\n")

    let startItems = lines[1].split(separator: ": ")[1].split(separator: ", ").map {
      BigInt($0)!
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

    let throwDestination = { (value: BigInt) in
      (value % BigInt(testDivisor)).isZero ? testTrueMonkey : testFalseMonkey
    }

    return Monkey(
      items: startItems, operation: operation, throwDestination: throwDestination,
      testDivisor: testDivisor)
  }

  public struct Monkey {
    public var items: [BigInt]
    public let operation: MonkeyOperation
    public let throwDestination: (BigInt) -> Int
    public let testDivisor: Int

    public var totalInspected = 0
  }

  public enum MonkeyOperation {
    case multiplied(by: Int)
    case plus(_ adder: Int)
    case squared
  }

  public static func monkeyBusiness(_ incomingMonkeys: [Monkey], rounds: Int) -> Int {
    let monkeys = (1...rounds).reduce(incomingMonkeys) { ms, _ in
      Day11.doARound(ms, divideWorryBy: 3)
    }
    return mostActiveMonkeys(monkeys)
  }

  public static func monkeyBusinessWithoutWorryReduction(_ incomingMonkeys: [Monkey], rounds: Int)
    -> Int
  {
    let monkeys = (1...rounds).reduce(incomingMonkeys) { ms, _ in
      return Day11.doARound(ms)
    }
    return mostActiveMonkeys(monkeys)
  }

  private static func mostActiveMonkeys(_ monkeys: [Monkey], limit: Int = 2) -> Int {
    let mostActiveMonkeys = Array(monkeys.map(\.totalInspected).sorted().reversed())
    return mostActiveMonkeys.prefix(limit).reduce(1, *)
  }

  public static func doARound(_ incomingMonkeys: [Monkey], divideWorryBy: Double = 1) -> [Monkey] {
    var monkeys = incomingMonkeys
    let monkeysLcm = BigInt(lcm(incomingMonkeys.map(\.testDivisor)))

    for index in monkeys.indices {
      let monkey = monkeys[index]
      for item in monkey.items {
        let nextWorry = performOperation(monkey.operation, old: item)
        let reducedWorry =
          divideWorryBy > 1
          ? nextWorry / BigInt(divideWorryBy)
          : nextWorry % monkeysLcm
        let throwDest = monkey.throwDestination(reducedWorry)

        monkeys[index].totalInspected += 1
        monkeys[throwDest].items.append(reducedWorry)
      }

      monkeys[index].items = []
    }

    return monkeys
  }

  public static func performOperation(_ operation: MonkeyOperation, old: BigInt) -> BigInt {
    switch operation {
    case .multiplied(by: let mult):
      return old * BigInt(mult)
    case .plus(let adder):
      return old + BigInt(adder)
    case .squared:
      return old * old
    }
  }

  private static func chunkArray<E>(_ arr: [E], into size: Int) -> [[E]] {
    return stride(from: 0, to: arr.count, by: size).map {
      Array(arr[$0..<min($0 + size, arr.count)])
    }
  }

  private static func lcm(_ ofNums: [Int]) -> Int {
    return ofNums.reduce(ofNums[0]) { lcm($0, $1) }
  }

  private static func lcm(_ lhs: Int, _ rhs: Int) -> Int {
    return (lhs * rhs) / gcf(lhs, rhs)
  }

  private static func gcf(_ lhs: Int, _ rhs: Int) -> Int {
    var attemptNumber = min(lhs, rhs)

    while attemptNumber > 0 {
      if lhs % attemptNumber == 0 && rhs % attemptNumber == 0 { return attemptNumber }
      attemptNumber -= 1
    }

    fatalError("No GCF for \(lhs) and \(rhs)")
  }
}
