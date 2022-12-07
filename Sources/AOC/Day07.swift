import Foundation

public protocol FSItem {
  subscript(index: any StringProtocol) -> FSItem? { get }
  var size: Int { get }
  var name: String { get }
}

public struct File: FSItem {
  public let name: String
  public let size: Int

  public subscript(index: any StringProtocol) -> FSItem? {
    return nil
  }
}

var DirParentCache: [UUID: Dir] = [:]

public class Dir: FSItem, ReflectedStringConvertible {
  public let name: String
  private let uuid = UUID()
  public var items: [String: FSItem] = [:]

  init(name: any StringProtocol, items: [FSItem] = []) {
    self.name = String(name)
    self.items = items.reduce(into: [:]) { $0[$1.name] = $1 }
  }

  @discardableResult func addItem<S: FSItem>(_ item: S) -> S {
    items[item.name] = item

    if let dir = item as? Dir {
      DirParentCache[dir.uuid] = self
    }

    return item
  }

  private var calculatedSize: Int? = nil
  public var size: Int {
    if calculatedSize == nil {
      calculatedSize = items.values.reduce(0) { $0 + $1.size }
    }

    if let calculatedSize {
      return calculatedSize
    } else {
      fatalError("Couldn't calculate size")
    }
  }

  public var parent: Dir? {
    return DirParentCache[uuid]
  }

  public subscript(index: any StringProtocol) -> FSItem? {
    return items[String(index)]
  }
}

public struct Day07 {
  public static func moderatelySizedDirs(_ input: String, limit: Int = 100000) -> [Dir] {
    let tree = dirTree(input)
    var dirsWeCareAbout: [Dir] = []

    walk(tree) { dir in
      guard let dir = dir as? Dir else { return }

      if dir.size < limit { dirsWeCareAbout.append(dir) }
    }

    return dirsWeCareAbout
  }

  private static func walk(_ tree: Dir, forEach: (FSItem) -> Void) {
    tree.items.forEach { (_, item) in
      if let dir = item as? Dir {
        walk(dir, forEach: forEach)
      }

      forEach(item)
    }
  }

  public static func dirTree(_ input: String) -> Dir {
    let lines = Utils.cleanLines(input)
    let root = Dir(name: "/")

    var pwd = root
    var lineCursor = lines.startIndex

    while lineCursor < lines.endIndex {
      (pwd, lineCursor) = processCommand(lines: lines, lineCursor: lineCursor, pwd: pwd, root: root)
    }

    return root
  }

  private static func processCommand(lines: [Substring], lineCursor: Int, pwd: Dir, root: Dir) -> (
    Dir, Int
  ) {
    let line = lines[lineCursor]
    var nextCursor = lineCursor
    var nextPwd = pwd

    guard lineIsCommand(line) else { fatalError("You fucked up the cursor position: \(line)") }

    let command = line.dropFirst(2).split(separator: " ")

    switch command.first {
    case "cd":
      nextPwd = processCD(command: command, pwd: pwd, root: root)
      nextCursor += 1
    case "ls":
      let nextLine = lineCursor + 1
      let untilNextCommand =
        lines[nextLine...].firstIndex(where: lineIsCommand(_:)) ?? lines.endIndex

      lines[nextLine..<untilNextCommand].forEach { item in
        pwd.addItem(lineToFsItem(item))
      }
      nextCursor += (untilNextCommand - nextLine) + 1
    default:
      fatalError("Don't know what to do with \(command.first ?? "nil")")
    }

    return (nextPwd, nextCursor)
  }

  private static func processCD(command: [Substring], pwd: Dir, root: Dir) -> Dir {
    switch command.last {
    case "/":
      return root
    case "..":
      if let parent = pwd.parent {
        return parent
      } else {
        fatalError("Couldn't find parent for \(pwd)")
      }
    default:
      if let child = pwd[command.last!] as? Dir {
        return child
      } else {
        return pwd.addItem(Dir(name: String(command.last!)))
      }
    }
  }

  private static func lineToFsItem(_ line: Substring) -> FSItem {
    let parts = line.split(separator: " ")

    switch parts.first {
    case "dir":
      return Dir(name: parts.last!)
    default:
      return File(name: String(parts.last!), size: Int(parts.first!)!)
    }
  }

  private static func lineIsCommand(_ line: any StringProtocol) -> Bool {
    return line.starts(with: "$ ")
  }
}
