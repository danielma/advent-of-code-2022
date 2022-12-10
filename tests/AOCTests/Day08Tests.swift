import AOC
import Foundation
import Nimble
import Quick

class Day08Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day08.txt")

    let realInput = try! String(contentsOf: resourceURL)

    let testInput = """
      30373
      25512
      65332
      33549
      35390
      """

    /*
     A tree is visible if all of the other trees between it and an edge of the grid are shorter than
     it. Only consider trees in the same row or column; that is, only look up, down, left, or right
     from any given tree.

     All of the trees around the edge of the grid are visible - since they are already on the edge,
     there are no trees to block the view. In this example, that only leaves the interior nine trees
     to consider:

     - The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom
       since other trees of height 5 are in the way.)
     - The top-middle 5 is visible from the top and right.
     - The top-right 1 is not visible from any direction; for it to be visible, there would
       need to only be trees of height 0 between it and an edge.
     - The left-middle 5 is visible, but only from the right.
     - The center 3 is not visible from any direction; for it to be visible, there would need to
       be only trees of at most height 2 between it and an edge.
     - The right-middle 3 is visible from the right.
     - In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

     With 16 trees visible on the edge and another 5 visible in the interior, a total of 21
     trees are visible in this arrangement.

     Consider your map; how many trees are visible from outside the grid?
     */

    it("part 1, initial test") {
      let treeMap = Day08.treeMap(testInput)

      expect(Day08.visibleFrom(.west, treeMap)).to(contain(Day08.Point(x: 1, y: 1)))
      expect(Day08.visibleFrom(.north, treeMap)).to(contain(Day08.Point(x: 1, y: 1)))
      expect(Day08.visibleFrom(.north, treeMap)).to(contain(Day08.Point(x: 2, y: 1)))
      expect(Day08.visibleFrom(.north, treeMap)).to(contain(Day08.Point(x: 3, y: 4)))
      expect(Day08.visibleFrom(.east, treeMap)).to(contain(Day08.Point(x: 1, y: 2)))

      // this is broke
      expect(Day08.visibleFrom(.east, treeMap)).notTo(contain(Day08.Point(x: 1, y: 1)))
    }

    it("part 1, test input") {
      expect(Day08.treesVisibleFromOutside(testInput)).to(equal(21))
    }

    it("part 1, real input") {
      expect(Day08.treesVisibleFromOutside(realInput)).to(equal(1763))
    }
  }
}
