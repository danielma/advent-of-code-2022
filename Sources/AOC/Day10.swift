import Foundation

public struct Day10 {
  public class CPU {
    var tickNo = 1
    var operationTickNo = 1

    private var _currentInstruction: Substring?
    var currentInstruction: Substring? {
      get { return _currentInstruction }
      set(nextInstruction) {
        if let nextInstruction {
          currentOperation = parseOperation(nextInstruction)
        }

        _currentInstruction = nextInstruction
      }
    }
    var currentOperation: Operation!

    enum Operation {
      case noop
      case addx(count: Int)
    }

    private func operationTickTime(_ operation: Operation) -> Int {
      switch operation {
      case .noop: return 1
      case .addx(_): return 2
      }
    }

    private func finishOperation(_ operation: Operation) {
      switch operation {
      case .noop: return
      case .addx(let count): registerX += count
      }
    }

    public var registerX = 1

    public init() {
    }

    public func exec(_ input: String, onTick: (Int) -> Void) {
      // run one extra time through the loop
      var lines = Utils.cleanLines(input) + [nil]

      currentInstruction = lines.removeFirst()

      while lines.count > 0 {
        onTick(tickNo)
        tick()

        if currentInstruction == nil {
          currentInstruction = lines.removeFirst()
        }
        tickNo += 1
      }
    }

    public func execCollect(_ input: String, interestingTicks: [Int]) -> [Int: Int] {
      var signals: [Int: Int] = [:]

      exec(input) { tickNo in
        if interestingTicks.contains(tickNo) {
          signals[tickNo] = registerX * tickNo
        }
      }

      return signals
    }

    private func tick() {
      let needed = operationTickTime(currentOperation)

      if needed == operationTickNo {
        operationTickNo = 1
        finishOperation(currentOperation)
        currentInstruction = nil
      } else {
        operationTickNo += 1
      }
    }

    private func parseOperation(_ instruction: Substring) -> Operation {
      let parts = instruction.split(separator: " ")

      switch parts.first! {
      case "noop": return .noop
      case "addx":
        return .addx(count: Int(parts.last!)!)
      default:
        fatalError("No operation for \(parts.first!)")
      }
    }
  }
}
