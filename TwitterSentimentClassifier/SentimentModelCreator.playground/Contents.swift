import Cocoa
import CreateML
import NaturalLanguage

class NLP {
    let text : String
    let stopwords : Set<String>
    public var tokens = Array<String>()
    public var lemma = Array<String>()
    
    init(text: String, stopwords: Set<String>) {
        self.text = text
        self.stopwords = stopwords
    }
    
    func tokenizeText() {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        self.tokens = Array<String>()
        let range = text.startIndex..<text.endIndex
        tokenizer.enumerateTokens(in: range, using: { (tokenRange, _) -> Bool in
            print(text[tokenRange], type(of: text[tokenRange]))
            let token = String(text[tokenRange])
            self.tokens.append(token)
            return true
        })
    }
    
    func removeStopwords() {
        let tokenizer = NLTokenizer(unit: .word)
        tokenizer.string = text
        self.tokens = Array<String>()
        let range = text.startIndex..<text.endIndex
        tokenizer.enumerateTokens(in: range, using: { (tokenRange, _) -> Bool in
            let token = String(text[tokenRange])
            if self.stopwords.contains(token) == false {
                self.tokens.append(token)
            }
            return true
        })
    }
    
    func lemmatize() {
        let tagger = NSLinguisticTagger(tagSchemes: [.language, .nameType, .lemma], options: 0)
        var options = NSLinguisticTagger.Options()
        options = [.omitPunctuation, .omitWhitespace, .joinNames]
        tagger.string = self.text
        
        self.lemma = Array<String>()
        
        let textRange = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: textRange, unit: .word, scheme: .lemma, options: options, using: { (tag, range, _) in
            if let lemma = tag?.rawValue {
                let word = (text as NSString).substring(with: range)
//                print(word, lemma)
                self.lemma.append(lemma)
            }
        })
        
    }

}

var fileManager = FileManager.default

var stop = Array<String>()
if fileManager.fileExists(atPath: "stopwords.txt") {
    let readFile = try String(contentsOf: URL(fileURLWithPath: "stopwords.txt"), encoding: .utf8)
    stop = readFile.components(separatedBy: .newlines)
}

let stopwords = Set(stop)


let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "twitter-sanders-apple3.csv"))

let tweets = Array(data["text"])
var processedText = Array<String>()
for tweet in tweets {
    if let unwrappedTweet = tweet.stringValue {
        let nlp = NLP(text: unwrappedTweet, stopwords: stopwords)
        nlp.lemmatize()
        let newTweetArray = nlp.lemma
        let newTweet = newTweetArray.joined(separator: " ")
        processedText.append(newTweet)
    }
}

print(processedText[10])

let dataColumn = MLDataColumn(processedText)



func trainModel() {
    do {
        var data = try MLDataTable(contentsOf: URL(fileURLWithPath: "twitter-sanders-apple3.csv"))
        data.addColumn(dataColumn, named: "processedData")
        let(trainData, testData) = data.randomSplit(by: 0.80, seed: 5)
        do {
            let classifier = try MLTextClassifier(trainingData: trainData, textColumn: "processedData", labelColumn: "class")
            let evaluationMetrics = classifier.evaluation(on: testData, textColumn: "processedData", labelColumn: "class")
            
            let accuracy = (1.0 - evaluationMetrics.classificationError) * 100
            print(accuracy)
            print(evaluationMetrics.precisionRecall)
            print(evaluationMetrics.confusion)
            
            let metaData = MLModelMetadata(author: "author", shortDescription: "A model to predict sentiment on Tweets", license: nil, version: "1.0", additional: nil)
//            try classifier.write(to: URL(fileURLWithPath: "daveModelPath.mlmodel"))
            let prediction = try classifier.prediction(from: "apple is a terrible company")
            print(prediction)
        } catch {
            print("could not train model. Check classifier parameters")
        }
        
    } catch {
        print("cannot load data")
        print(error)
    }
}

trainModel()


