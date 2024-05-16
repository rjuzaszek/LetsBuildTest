# Box Filling App

## Overview
This SwiftUI application is designed to solve the minimal cube count problem for filling a box. Users can choose between two algorithmic approaches: a Greedy method and a Dynamic Programming method. The application allows users to run test examples from a file, select their preferred algorithm, and view the execution time for each method.

## Features
- **Algorithm Selection**: Choose between a Greedy algorithm or a Dynamic Programming approach.
- **Performance Metrics**: View the elapsed time for the selected algorithm's execution.

## Installation
To run the Box Filling App, you need to have Xcode installed on your macOS system as it is built using SwiftUI.

1. **Clone the repository**:
- git clone https://github.com/rjuzaszek/LetsBuildTest.git)
2. **Open the project**:
- Navigate to the cloned directory and open the project in Xcode by double-clicking on `myprogram.xcodeproj`.

3. **Build and Run**:
- Select a target device or simulator.
- Press `Cmd + R` to build and run the application.
- alternatively compile main.swift file and run from the console with problems.txt file input (this contains only working greedy algorythm)

## Files
- `main.swift`: Contains the main entry point of the program to fill requirements of the task
- `LetsBuildTest.xcodeproj`: Xcode project file.
- `problem.txt`: Text file containing test cases for the application.

## Author
Robert Juzaszek

## Disclaimer
Dynamyic programming approach is a trial and doesn't give good results also it takes a lot of time to execute as it's complexity is much bigger then greedy one, so it's just a feature to showcase possible app construction here, please don't take it into consideration when checking results :)
