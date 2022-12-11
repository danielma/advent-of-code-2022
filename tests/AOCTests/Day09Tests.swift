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

    it("part 1, test input") {
      let locations = Day09.visitedRopeLocations(testInput)

      expect(Set(locations).count).to(equal(13))
    }

    it("part 1, real input") {
      let locations = Day09.visitedRopeLocations(realInput)

      expect(Set(locations).count).to(equal(6314))
    }
  }
}
