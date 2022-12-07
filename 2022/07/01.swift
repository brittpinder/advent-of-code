import Foundation

struct File {
    let name: String
    let size: Int
}

class Folder {
    let name: String
    var files: [File]
    var folders: [Folder]
    var parent: Folder?

    init(name: String, parent: Folder?) {
        self.name = name
        self.parent = parent
        files = [File]()
        folders = [Folder]()
    }

    func addFile(name: String, size: Int) {
        files.append(File(name: name, size: size))
    }

    func addFolder(name: String, parent: Folder?) {
        folders.append(Folder(name: name, parent: parent))
    }

    func getFolderWithName(_ name: String) -> Folder? {
        return folders.first(where: {$0.name == name})
    }

    func getSize() -> Int {
        var totalSize = files.reduce(0){ size, file in
            size + file.size
        }
        totalSize += folders.reduce(0){ size, folder in
            size + folder.getSize()
        }
        return totalSize
    }
}

func changeDirectory(root: Folder, currentDirectory: inout Folder, directoryName: String) {
    if directoryName == "/" {
        currentDirectory = root
    } else if directoryName == ".." {
        if let parent = currentDirectory.parent {
            currentDirectory = parent
        }
    } else {
        guard let nextDirectory = currentDirectory.getFolderWithName(directoryName) else {
            assertionFailure("Directory with name \(directoryName) not found!")
            return
        }
        currentDirectory = nextDirectory
    }
}

func createFileSystem(input: [String]) -> Folder {
    enum Command {
        case cd, ls
    }

    var currentCommand: Command?
    let root = Folder(name: "/", parent: nil)
    var currentDirectory = root

    for line in input {
        if line.hasPrefix("$") {
            let values = line.split(separator: " ")
            switch values[1] {
                case "cd":
                    currentCommand = Command.cd
                    changeDirectory(root: root, currentDirectory: &currentDirectory, directoryName: String(values[2]))
                case "ls":
                    currentCommand = Command.ls
                default:
                    assertionFailure("Unrecognized command!")
            }
        } else if currentCommand == Command.ls {
            if line.hasPrefix("dir") {
                let folderName = String(line.split(separator: " ")[1])
                currentDirectory.addFolder(name: folderName, parent: currentDirectory)
            } else {
                let fileData = line.split(separator: " ")
                currentDirectory.addFile(name: String(fileData[1]), size: Int(fileData[0])!)
            }
        } else {
            assertionFailure("Unrecognized line: \(line)")
        }
    }
    return root
}

let contents = try! String(contentsOfFile: "input").split(separator: "\n")
                                                   .map{String($0)}
let rootFolder = createFileSystem(input: contents)

// Part 1
var totalSize = 0
var folders = [rootFolder]
while !folders.isEmpty {
    if let currentFolder = folders.popLast() {
        let folderSize = currentFolder.getSize()
        if folderSize < 100000 {
            totalSize += folderSize
        }
        folders += currentFolder.folders
    }
}

let answer1 = totalSize
print(answer1)
assert(answer1 == 1648397, "Wrong answer! Expected 1648397")

// Part 2
let unusedSpace = 70000000 - rootFolder.getSize()
let requiredSpace = 30000000 - unusedSpace

var deletionCandidates = [Int]()
folders = [rootFolder]
while !folders.isEmpty {
    if let currentFolder = folders.popLast() {
        let folderSize = currentFolder.getSize()
        if folderSize >= requiredSpace {
            deletionCandidates.append(folderSize)
        }
        folders += currentFolder.folders
    }
}

let answer2 = deletionCandidates.sorted()[0]
print(answer2)
assert(answer2 == 1815525, "Wrong answer! Expected 1815525")
