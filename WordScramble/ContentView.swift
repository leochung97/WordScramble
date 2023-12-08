import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
            }
            .navigationTitle(rootWord)
        }
        
        //        List {
//            Text("Static")
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//            Text("Static")
//        }
        
//        List {
//            Section("Section 1") {
//                Text("Static Row 1")
//                Text("Static Row 2")
//            }
//            
//            Section("Section 2") {
//                ForEach(1..<6) {
//                    Text("This is row \($0)")
//                }
//            }
//            
//            Section("Section 3") {
//                Text("Static Row 1")
//                Text("Static Row 2")
//            }
//        }
//        .listStyle(.grouped)
    }
    
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        // exit if the remaining string is empty
        guard answer.count > 0 else { return }

        // extra validation to come

        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func testBundles() {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                // we loaded the file into a string!
            }
        }
    }
    
    func testStrings() {
        let input = """
                    a
                    b
                    c
                    """
        let letters = input.components(separatedBy: "\n")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func testChecker(word: String) {
        // There is a built-in spell checker in SwiftUI
        // However, it utilizes UIKit which was originally built on Objective-C so it requires a few steps to enable
        
        // Create an instance of UITextChecker() that will be used to check the string
        let checker = UITextChecker()
        // We need to encode the word into utf16 (we need to create this string because Objective-C does not use this method to store letters
        let range = NSRange(location: 0, length: word.utf16.count)
        // We can then return the mispelled range of our text
        // Objective-C doesn't have any concept of optionals, so instead we rely on special values to represent missing data
        // If we receive NSNotFound -> the spell check deemed that the word was spelled correctly
        // Otherwise, we receive a range of values that indicate where the word was mispelled
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
    }
}

#Preview {
    ContentView()
}
