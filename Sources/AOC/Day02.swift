import Foundation

enum Weapon: Int {
  case rock = 1
  case paper = 2
  case scissors = 3
}

enum Outcome: Int {
  case win = 6
  case draw = 3
  case lose = 0
}

struct Play {
  let call: Weapon
  let response: Weapon
}

struct SecretivePlay {
  let call: Weapon
  let response: Outcome
}

public struct Day02 {
  /*
     The winner of the whole tournament is the player with the highest score. Your total score is
     the sum of your scores for each round. The score for a single round is the score for the shape
     you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of
     the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
     */
  public static func scoreWithDeterministicResponses(_ input: String) -> Int {
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

  public static func scoreWithSecretiveResponses(_ input: String) -> Int {
    let secretPlays = cleanInput(input).split(separator: "\n").map { row in
      let parts = row.split(separator: " ").map { String($0) }

      return SecretivePlay(
        call: callToWeapon(parts.first!),
        response: responseToOutcome(parts.last!)
      )
    }

    let plays = secretPlays.map { play in
      let response = {
        switch play.response {
        case .draw:
          return play.call
        case .win:
          switch play.call {
          case .rock: return .paper
          case .paper: return .scissors
          case .scissors: return .rock
          }
        case .lose:
          switch play.call {
          case .rock: return .scissors
          case .paper: return .rock
          case .scissors: return .paper
          }
        }
      }()

      return Play(call: play.call, response: response)
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

  private static func responseToOutcome(_ response: String) -> Outcome {
    switch response {
    case "X": return .lose
    case "Y": return .draw
    case "Z": return .win
    default: fatalError("WTF \(response)")
    }
  }

  private static func scorePlay(_ play: Play) -> Int {
    return scoreChoice(play) + scoreOutcome(play)
  }

  private static func scoreChoice(_ play: Play) -> Int {
    return play.response.rawValue
  }

  private static func scoreOutcome(_ play: Play) -> Int {
    return outcome(play).rawValue
  }

  private static func outcome(_ play: Play) -> Outcome {
    if play.call == play.response {
      return .draw
    } else {
      switch (play.call, play.response) {
      case (.rock, .paper): return .win
      case (.rock, .scissors): return .lose
      case (.paper, .rock): return .lose
      case (.paper, .scissors): return .win
      case (.scissors, .rock): return .win
      case (.scissors, .paper): return .lose
      default: fatalError("What game did you play? \(play)")
      }
    }
  }

  private static func cleanInput(_ input: String) -> String {
    return input.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
