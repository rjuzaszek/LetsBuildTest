//
//  ContentView.swift
//  LetsBuildTest
//
//  Created by Robert Juzaszek on 15/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    enum AlgorythmType: String {
        case greedy
        case dynamic
        
        var executor: BoxFillingStrategy {
            switch self {
            case .greedy:
                return GreedyBoxFillingStrategy()
            case .dynamic:
                return DynamicBoxFillingStrategy()
            }
        }
    }
    
    @State private var selectedAlgorythm: AlgorythmType = .greedy
    @State private var outputText: String = ""
    @State private var fileContent: String = ""
    @State private var time: String = "..."
    
    var body: some View {
        VStack {
            Picker("Select algorythm type", selection: $selectedAlgorythm) {
                Text(AlgorythmType.greedy.rawValue.capitalized).tag(AlgorythmType.greedy)
                Text(AlgorythmType.dynamic.rawValue.capitalized).tag(AlgorythmType.dynamic)
            }
            .pickerStyle(.segmented)
            .padding(.bottom, 16)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Input: ")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                        .padding(.bottom, 8)
                    Text(fileContent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2)) // Optional: for better visibility

                VStack(alignment: .leading) {
                    Text("Result:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                        .padding(.bottom, 8)
                    Text(outputText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .truncationMode(.tail)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2)) // Optional: for better visibility
            }
            .frame(maxHeight: .infinity)
            
            Spacer()
            
            Text("Ellapsed time: \(time)")
                .padding(.vertical, 16)
            
            Button("Calculate") {
                outputText = "Calculating..."
                time = "..."
                
                // TODO: improove a bit background task handling with async/await
                DispatchQueue.global().async {
                    self.executeAlgorythm()
                }
            }
            
        }
        .padding()
        .onAppear {
            loadFile()
        }
    }
    
    func loadFile() {
        guard let path = Bundle.main.path(forResource: "problems", ofType: "txt") else {
            fileContent = "File not found."
            return
        }

        do {
            let content = try String(contentsOfFile: path)
            fileContent = content
        } catch {
            fileContent = "Error reading file: \(error)"
        }
    }
    
    func executeAlgorythm() {
        let lines = fileContent.components(separatedBy: .newlines)
        var results = [String]()

        let timestampStart = Date.timeIntervalSinceReferenceDate
        for line in lines {
            if line.isEmpty { continue }
            
            let algorythm: BoxFillingStrategy = selectedAlgorythm.executor
            let result = algorythm.solve(line: line)
            results.append("\(result)")
        }
        let timestampEnd = Date.timeIntervalSinceReferenceDate
        let time = timestampEnd - timestampStart
        
        DispatchQueue.main.async {
            self.time = "\(time)s"
            self.outputText = results.joined(separator: "\n")
        }
    }
}

#Preview {
    ContentView()
}
