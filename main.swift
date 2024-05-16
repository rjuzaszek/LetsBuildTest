import Foundation

class GreedyBoxFillingStrategy {
    
    struct BoxSize {
        let length: Int
        let width: Int
        let height: Int
        let volume: Int
        
        init(length: Int, width: Int, height: Int) {
            self.length = length
            self.width = width
            self.height = height
            self.volume = length * width * height
        }
        
        func getCubesFitCount(for cubeSize: Int) -> Int {
            // Faster raising 2 to cubeSize power using bit shift equivalent of pow(2, cubeSize)
            let cubeVolume = 1 << cubeSize
            return (length / cubeVolume) * (width / cubeVolume) * (height / cubeVolume)
        }
    }
    
    private func findMinCubesCount(box: BoxSize, cubes: [Int]) -> Int {
        var alreadyFilledVolume = 0
        var minBoxCount = 0
        
        for i in stride(from: cubes.count-1, through: 0, by: -1) {
            var currentlyFitedCubes = box.getCubesFitCount(for: i)
            currentlyFitedCubes -= alreadyFilledVolume
            
            if currentlyFitedCubes > cubes[i] {
                currentlyFitedCubes = cubes[i]
            }
            
            alreadyFilledVolume = (alreadyFilledVolume + currentlyFitedCubes) * 8
            minBoxCount += currentlyFitedCubes
        }
        
        guard alreadyFilledVolume >= 8 * box.volume else { return -1 }
        return minBoxCount
    }
    
    func solve(line: String) -> Int {
        let parts = line.split(separator: " ").compactMap { Int($0) }
        let box = BoxSize(length: parts[0], width: parts[1], height: parts[2])
        let cubes = Array(parts[3...])
        return findMinCubesCount(box: box, cubes: cubes)
    }
}


// Read from standard input
let input = FileHandle.standardInput.readDataToEndOfFile()
let inputString = String(data: input, encoding: .utf8) ?? ""
let lines = inputString.components(separatedBy: .newlines)

for line in lines {
    let algorythm = GreedyBoxFillingStrategy()
    let result = algorythm.solve(line: line)
    print(result)
}