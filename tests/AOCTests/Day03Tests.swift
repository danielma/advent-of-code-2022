import AOC
import Foundation
import Nimble
import Quick

class Day03Spec: QuickSpec {
  override func spec() {
    let testInput = """
      vJrwpWtwJgWrhcsFMMfFFhFp
      jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      PmmdzqPrVvPwwTWBwg
      wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ttgJtRGJQctTZtZT
      CrZsJsPPZsGzwwsLwLmpwMDw
      """

    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()
    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day03.txt")

    let realInput = try! String(contentsOf: resourceURL)

    it("part 1, test input") {
      expect(Day03.prioritiesSum(testInput)).to(equal(157))
    }

    it("part 1, real input") {
      expect(Day03.prioritiesSum(realInput)).to(equal(8243))
    }

    it("part 2, test input") {
      expect(Day03.groupPrioritiesSum(testInput)).to(equal(70))
    }

    it("part 2, real input") {
      expect(Day03.groupPrioritiesSum(realInput)).to(equal(2631))
    }
  }
}
