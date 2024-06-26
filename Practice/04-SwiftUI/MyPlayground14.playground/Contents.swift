
//var treeArray : [String] = ["Pine", "Oak", "Yew"]
var treeArray = ["Pine", "Oak", "Yew"]


var priceArray = [Float]()

var nameArray = [String](repeating : "MyString",count : 10)


let firstArray = ["Red","Green","Blue"]
let secondArray = ["Indigo","Violet"]

let thirdArray = firstArray + secondArray
print(thirdArray.count) //array counting
print(treeArray.isEmpty) // empty OR NOT checking

print(treeArray[2])

treeArray[1] = "Redwood"
//treeArray  += ["Redwood"] same with upline


treeArray = treeArray + ["Maple", "Birch"]
treeArray.shuffle()
print(treeArray)

//array in random func
print(treeArray.randomElement() ?? "")

//var bookDict: [String:String] = ["100-432112": "Wind in the Willows"]
var bookDict1 = ["100-432112": "Wind in the Willows"]
// 빈 딕셔너리 초기화 정수형 키값, 문자열
var myDictionary = [Int: String]()

let keys = ["1","2","3","4","5","6","7"]
let values = ["Value1","Value2","Value3","Value4","Value5","Value6","Value7",]

//let bookDict = Dictionary(uniqueKeysWithValues: zip(keys, values))
var bookDict = Dictionary(uniqueKeysWithValues: zip(1..., values))

print(bookDict.count)
print(bookDict[1, default: "NoValue"] )
bookDict[1231000] = "Value"

for (bookId, value) in bookDict {
    print("Book Id: \(bookId) Value: \(value)")
}
