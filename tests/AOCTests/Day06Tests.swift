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

    it("part 2, first test") {
      let testInput = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

      expect(Day06.messageStartIndex(testInput)).to(equal(19))
    }

    it("part 2, second test") {
      let testInput = "bvwbjplbgvbhsrlpgdmjqwftvncz"

      expect(Day06.messageStartIndex(testInput)).to(equal(23))
    }

    it("part 2, third test") {
      let testInput = "nppdvjthqldpwncqszvftbrmjlhg"

      expect(Day06.messageStartIndex(testInput)).to(equal(23))
    }

    it("part 2, fourth test") {
      let testInput = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"

      expect(Day06.messageStartIndex(testInput)).to(equal(29))
    }

    it("part 2, fifth test") {
      let testInput = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

      expect(Day06.messageStartIndex(testInput)).to(equal(26))
    }

    it("part 2, real input") {
      expect(Day06.messageStartIndex(realInput)).to(equal(3965))
    }
  }
}
