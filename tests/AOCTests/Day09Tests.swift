import AOC
import Foundation
import Nimble
import Quick

class Day09Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day09.txt")

    let realInput = try! String(contentsOf: resourceURL)

    let testInput = """
      R 4
      U 4
      L 3
      D 1
      R 4
      D 1
      L 5
      R 2
      """

    let largerTestInput = """
      R 5
      U 8
      L 8
      D 3
      R 17
      D 10
      L 25
      U 20
      """

    it("part 1, test input") {
      let rope = Day09.Rope(length: 2)
      let locations = Day09.visitedTailLocations(testInput, rope: rope)

      expect(Set(locations).count).to(equal(13))
    }

    it("part 1, real input") {
      let rope = Day09.Rope(length: 2)
      let locations = Day09.visitedTailLocations(realInput, rope: rope)

      expect(Set(locations).count).to(equal(6314))
    }

    it("part 2, test input") {
      let rope = Day09.Rope(length: 10)
      let locations = Day09.visitedTailLocations(testInput, rope: rope)

      expect(Set(locations).count).to(equal(1))
    }

    it("part 2, larger test input") {
      let rope = Day09.Rope(length: 10)
      let locations = Day09.visitedTailLocations(largerTestInput, rope: rope)

      expect(Set(locations).count).to(equal(36))
    }

    it("part 2, real input") {
      let rope = Day09.Rope(length: 10)
      let locations = Day09.visitedTailLocations(realInput, rope: rope)

      expect(Set(locations).count).to(equal(2504))
    }
  }
}
