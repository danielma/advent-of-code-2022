import AOC
import Foundation
import Nimble
import Quick

class Day02Spec: QuickSpec {
  override func spec() {
    let testInput = """
      A Y
      B X
      C Z
      """

    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()
    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day02.txt")

    let realInput = try! String(contentsOf: resourceURL)

    it("part 1, test input") {
      expect(Day02.score(testInput)).to(equal(15))
    }

    it("part 1, real input") {
      expect(Day02.score(realInput)).to(equal(11767))
    }
  }
}
