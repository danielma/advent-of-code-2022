import AOC
import Foundation
import Nimble
import Quick

class Day11Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day11.txt")

    let realInput = try! String(contentsOf: resourceURL)

    /*
     Starting items lists your worry level for each item the monkey is currently holding in the
     order they will be inspected.

     Operation shows how your worry level changes as that monkey inspects an item. (An operation
     like new = old * 5 means that your worry level after the monkey inspected the item is five
     times whatever your worry level was before inspection.)

     Test shows how the monkey uses your worry level to decide where to throw an item next.
      If true shows what happens with an item if the Test was true.
      If false shows what happens with an item if the Test was false.
     */

    /*
     After each monkey inspects an item but before it tests your worry level, your relief that the
     monkey's inspection didn't damage the item causes your worry level to be divided by three and
     rounded down to the nearest integer.

     The monkeys take turns inspecting and throwing items. On a single monkey's turn, it inspects
     and throws all of the items it is holding one at a time and in the order listed. Monkey 0 goes
     first, then monkey 1, and so on until each monkey has had one turn. The process of each monkey
     taking a single turn is called a round.

     When a monkey throws an item to another monkey, the item goes on the end of the recipient
     monkey's list. A monkey that starts a round with no items could end up inspecting and throwing
     many items by the time its turn comes around. If a monkey is holding no items at the start of
     its turn, its turn ends.
     */

    let testInput = """
      Monkey 0:
        Starting items: 79, 98
        Operation: new = old * 19
        Test: divisible by 23
          If true: throw to monkey 2
          If false: throw to monkey 3

      Monkey 1:
        Starting items: 54, 65, 75, 74
        Operation: new = old + 6
        Test: divisible by 19
          If true: throw to monkey 2
          If false: throw to monkey 0

      Monkey 2:
        Starting items: 79, 60, 97
        Operation: new = old * old
        Test: divisible by 13
          If true: throw to monkey 1
          If false: throw to monkey 3

      Monkey 3:
        Starting items: 74
        Operation: new = old + 3
        Test: divisible by 17
          If true: throw to monkey 0
          If false: throw to monkey 1
      """

    it("part 1, test input, one round only") {
      var monkeys = Day11.parseMonkeys(testInput)
      monkeys = Day11.doARound(monkeys)

      expect(monkeys[0].items).to(equal([20, 23, 27, 26]))
      expect(monkeys[1].items).to(equal([2080, 25, 167, 207, 401, 1046]))
      expect(monkeys[2].items).to(equal([]))
      expect(monkeys[3].items).to(equal([]))
    }

    it("part 1, test input, the real calculations") {
      var monkeys = Day11.parseMonkeys(testInput)
      monkeys = (1...20).reduce(monkeys) { ms, _ in Day11.doARound(ms) }

      expect(monkeys.map(\.totalInspected)).to(equal([101, 95, 7, 105]))

      let mostActiveMonkeys = Array(monkeys.map(\.totalInspected).sorted().reversed())

      expect(mostActiveMonkeys[0...1].reduce(1, *)).to(equal(10605))
    }

    it("part 1, real input") {
      var monkeys = Day11.parseMonkeys(realInput)
      monkeys = (1...20).reduce(monkeys) { ms, _ in Day11.doARound(ms) }

      let mostActiveMonkeys = Array(monkeys.map(\.totalInspected).sorted().reversed())
      expect(mostActiveMonkeys[0...1].reduce(1, *)).to(equal(56595))
    }
  }
}
