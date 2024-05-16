//
//  DynamicBoxFillingStrategy.swift
//  LetsBuildTest
//
//  Created by Robert Juzaszek on 16/05/2024.
//

import Foundation

class DynamicBoxFillingStrategy: BoxFillingStrategy {
    
    // Deinition of cubes for size
    struct Cube {
        let size: Int
        let count: Int
        let volume: Int
        
        init(size: Int, count: Int) {
            self.size = size
            self.count = count
            self.volume = size * size * size
        }
    }
    
    // Definition of box to fill
    struct BoxAttempt: Hashable {
        let lenght: Int
        let width: Int
        let height: Int
        let volume: Int
        
        init(lenght: Int, width: Int, height: Int) {
            self.lenght = lenght
            self.width = width
            self.height = height
            self.volume = lenght * width * height
        }
        
        var isZero: Bool {
            lenght == 0 || width == 0 || height == 0
        }
        
        func isFitting(cube: Cube) -> Bool {
            lenght >= cube.size && height >= cube.size && width >= cube.size
        }
        
        func cubesPerDimension(cube: Cube) -> Int {
            (lenght / cube.size) * (width / cube.size) * (height / cube.size)
        }
    }
    
    private var tempResults = [BoxAttempt: Int]()
    private var cubes = [Cube]()
    
    // Function to attempt to fill the box (l x w x h)
    private func findMinBoxCount(attempt: BoxAttempt) -> Int {
        guard !attempt.isZero else { return 0 }
        
        if let cached = tempResults[attempt] {
            return cached
        }
        
        var minimumCubes = Int.max
        
        for cube in cubes where attempt.isFitting(cube: cube) {
            let cubesPerDimension = attempt.cubesPerDimension(cube: cube)
            let maxUsableCubes = min(cube.count, cubesPerDimension)
            
            if maxUsableCubes < cubes.count {
                return -1
            }
            
            for cubesUsed in stride(from: maxUsableCubes, through: 1, by: -1) {
                
                let subAttempt1 = BoxAttempt(
                    lenght: attempt.lenght,
                    width: attempt.width,
                    height: attempt.height - cube.size * cubesUsed
                )
                
                let subAttempt2 = BoxAttempt(
                    lenght: attempt.lenght,
                    width: attempt.width - cube.size,
                    height: cube.size * cubesUsed
                )
                
                let subAttempt3 = BoxAttempt(
                    lenght: attempt.lenght - cube.size,
                    width: cube.size,
                    height: cube.size * cubesUsed
                )
                
                let remaining = findMinBoxCount(attempt: subAttempt1) +
                                findMinBoxCount(attempt: subAttempt2) +
                                findMinBoxCount(attempt: subAttempt3)
                
                minimumCubes = min(minimumCubes, cubesUsed + remaining)
                if minimumCubes == cubesUsed { break }
            }
        }
        
        tempResults[attempt] = minimumCubes == Int.max ? -1 : minimumCubes
        return tempResults[attempt]!
    }
    
    func solve(line: String) -> Int {
        let parts = line.split(separator: " ").compactMap { Int($0) }
        
        for i in 3..<parts.count {
            let count = parts[i]
            let size = NSDecimalNumber(decimal: pow(2, i - 3)).intValue
            cubes.append(Cube(size: size, count: count))
        }
        
        cubes.sort(by: { $0.size > $1.size })
        
        let attempt = BoxAttempt(lenght: parts[0], width: parts[1], height: parts[2])
        let result = findMinBoxCount(attempt: attempt)
        return result == Int.max ? -1 : result
    }
}
