import AOC
import Foundation
import Nimble
import Quick

class Day05Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let testInput = """
          [D]
      [N] [C]
      [Z] [M] [P]
       1   2   3

      move 1 from 2 to 1
      move 3 from 1 to 3
      move 2 from 2 to 1
      move 1 from 1 to 2
      """

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day05.txt")

    let realInput = try! String(contentsOf: resourceURL)

    it("part 1, test input") {
      let crateMessage = String(Day05.execute9000Moves(testInput).map { $0.first! })

      expect(crateMessage).to(equal("CMZ"))
    }

    it("part 1, real input") {
      let crateMessage = String(Day05.execute9000Moves(realInput).map { $0.first! })

      expect(crateMessage).to(equal("RNZLFZSJH"))
    }

    it("part 2, test input") {
      let crateMessage = String(Day05.execute9001Moves(testInput).map { $0.first! })

      expect(crateMessage).to(equal("MCD"))
    }

    it("part 2, real input") {
      let crateMessage = String(Day05.execute9001Moves(realInput).map { $0.first! })

      expect(crateMessage).to(equal("CNSFCGJSM"))
    }
  }
}
