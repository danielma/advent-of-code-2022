import AOC
import Foundation
import Nimble
import Quick

class Day04Spec: QuickSpec {
  override func spec() {
    let testInput = """
      2-4,6-8
      2-3,4-5
      5-7,7-9
      2-8,3-7
      6-6,4-6
      2-6,4-8
      """

    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()
    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day04.txt")

    let realInput = try! String(contentsOf: resourceURL)

    it("part 1, test input") {
      expect(Day04.fullSubsetPairs(testInput)).to(equal(2))
    }

    it("part 1, real input") {
      expect(Day04.fullSubsetPairs(realInput)).to(equal(483))
    }

    it("part 2, test input") {
      expect(Day04.partialSubsetPairs(testInput)).to(equal(4))
    }

    it("part 2, real input") {
      expect(Day04.partialSubsetPairs(realInput)).to(equal(874))
    }
  }
}
