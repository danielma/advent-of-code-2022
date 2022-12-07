import AOC
import Foundation
import Nimble
import Quick

class Day06Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day06.txt")

    let realInput = try! String(contentsOf: resourceURL)

    it("part 1, first test") {
      let testInput = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

      expect(Day06.packetStartIndex(testInput)).to(equal(7))
    }

    it("part 1, second test") {
      let testInput = "bvwbjplbgvbhsrlpgdmjqwftvncz"

      expect(Day06.packetStartIndex(testInput)).to(equal(5))
    }

    it("part 1, third test") {
      let testInput = "nppdvjthqldpwncqszvftbrmjlhg"

      expect(Day06.packetStartIndex(testInput)).to(equal(6))
    }

    it("part 1, fourth test") {
      let testInput = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"

      expect(Day06.packetStartIndex(testInput)).to(equal(10))
    }

    it("part 1, fifth test") {
      let testInput = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

      expect(Day06.packetStartIndex(testInput)).to(equal(11))
    }

    it("part 1, real input") {
      expect(Day06.packetStartIndex(realInput)).to(equal(1109))
    }

    // it("part 2, test input") {
    //   let crateMessage = String(Day05.execute9001Moves(testInput).map { $0.first! })

    //   expect(crateMessage).to(equal("MCD"))
    // }

    // it("part 2, real input") {
    //   let crateMessage = String(Day05.execute9001Moves(realInput).map { $0.first! })

    //   expect(crateMessage).to(equal("CNSFCGJSM"))
    // }
  }
}
