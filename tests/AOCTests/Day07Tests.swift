import AOC
import Foundation
import Nimble
import Quick

class Day07Spec: QuickSpec {
  override func spec() {
    let thisSourceFile = URL(fileURLWithPath: #file)
    let thisDirectory = thisSourceFile.deletingLastPathComponent()

    let resourceURL = thisDirectory.appendingPathComponent("Inputs/day07.txt")

    let realInput = try! String(contentsOf: resourceURL)

    let testInput = """
      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k
      """

    // Find all of the directories with a total size of at most 100000.
    // What is the sum of the total sizes of those directories?

    it("part 1, limited test") {
      let tree = Day07.dirTree(testInput)

      expect(tree["a"]!["e"]!.size).to(equal(584))
      expect(tree["a"]!.size).to(equal(94853))
      expect(tree["d"]!.size).to(equal(24_933_642))
      expect(tree.size).to(equal(48_381_165))
    }

    it("part 1, test input") {
      let dirs = Day07.moderatelySizedDirs(testInput)

      expect(dirs.reduce(0) { $0 + $1.size }).to(equal(95437))
    }

    it("part 1, real input") {
      let dirs = Day07.moderatelySizedDirs(realInput)

      expect(dirs.reduce(0) { $0 + $1.size }).to(equal(1_334_506))
    }
  }
}
