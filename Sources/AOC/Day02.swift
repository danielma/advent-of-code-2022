import Foundation

enum Weapon {
  case rock
  case paper
  case scissors
}

struct Play {
  let call: Weapon
  let response: Weapon
}

public struct Day02 {
  /*
     The winner of the whole tournament is the player with the highest score. Your total score is
     the sum of your scores for each round. The score for a single round is the score for the shape
     you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of
     the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
     */
  public static func score(_ input: String) -> Int {
    let plays = cleanInput(input).split(separator: "\n").map { row in
      let parts = row.split(separator: " ").map { String($0) }

      return Play(
        call: callToWeapon(parts.first!),
        response: responseToWeapon(parts.last!)
      )
    }

    let scores = plays.map { scorePlay($0) }

    return scores.reduce(0, +)
  }

  private static func callToWeapon(_ call: String) -> Weapon {
    switch call {
    case "A": return .rock
    case "B": return .paper
    case "C": return .scissors
    default: fatalError("WTF \(call)")
    }
  }

  private static func responseToWeapon(_ response: String) -> Weapon {
    switch response {
    case "X": return .rock
    case "Y": return .paper
    case "Z": return .scissors
    default: fatalError("WTF \(response)")
    }
  }

  private static func scorePlay(_ play: Play) -> Int {
    return scoreChoice(play) + scoreOutcome(play)
  }

  private static func scoreChoice(_ play: Play) -> Int {
    switch play.response {
    case .rock:
      return 1
    case .paper:
      return 2
    case .scissors:
      return 3
    }
  }

  private static func scoreOutcome(_ play: Play) -> Int {
    if play.call == play.response {
      return 3
    } else {
      switch (play.call, play.response) {
      case (.rock, .paper): return 6
      case (.rock, .scissors): return 0
      case (.paper, .rock): return 0
      case (.paper, .scissors): return 6
      case (.scissors, .rock): return 6
      case (.scissors, .paper): return 0
      default: fatalError("What game did you play? \(play)")
      }
    }
  }

  private static func cleanInput(_ input: String) -> String {
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
