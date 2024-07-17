
enum WebsiteError: Error {
    case noInternetConnection
    case siteDown
    case wrongURL
}


func checkWebsite(siteUp: Bool) throws -> String {
    if siteUp == false {
        throw WebsiteError.siteDown
    }
    return "Site is up"
}

let siteStatus = false
do {
    print(try checkWebsite(siteUp: siteStatus))
} catch {
    print("error: \(error)")
}


//protocol CalorieCount {
//    var calories: Int { get }
//    func description() -> String
//}
//
//class Burger: CalorieCount {
//    var calories: Int = 800
//    
//    func description() -> String {
//        return "This burger has \(calories) calories"
//    }
//}
//
//struct Fries: CalorieCount {
//    var calories: Int {
//        return 500
//    }
//    
//    func description() -> String {
//        return "These fries have \(calories) calories"
//    }
//}
//
//enum Sauce {
//    case chili
//    case tomato
//}
//
//extension Sauce: CalorieCount {
//    var calories: Int {
//        switch self {
//        case .chili:
//            return 50
//        case .tomato:
//            return 80
//        }
//    }
//    
//    func description() -> String {
//        return  "This sauce has \(calories) calories"
//    }
//}
//let burger = Burger()
//let fries = Fries()
//let sauce = Sauce.tomato
//
//let foodArray: [CalorieCount] = [burger, fries, sauce]
//
//var totalCalories = 0
//for food in foodArray {
//    totalCalories += food.calories
//}
//print(totalCalories)
//
//enum TrafficLightColor: String {
//    case red = "r"
//    case yellow = "y"
//    case green = "g"
//
//    func description() -> String {
//        switch self {
//        case .red:
//            return "red"
//        case .yellow:
//            return "yellow"
//        case .green:
//            return "green"
//        }
//    }
//}
//
//var trafficLightColor = TrafficLightColor.red
//print(trafficLightColor.description())
//print(trafficLightColor.rawValue)

//struct Reptile {
//    var name: String
//    var sound: String
//    var numberOfLegs: Int
//    var breathesOxygen: Bool
//    let hasFurOrHair: Bool = false
//
//    func makeSound() {
//        print(sound)
//    }
//
//    func description() -> String {
//        return "Struct name: \(self.name) \nsound: \(self.sound) \nnumberOfLegs: \(self.numberOfLegs) \nbreathesOxygen: \(self.breathesOxygen)"
//    }
//
//}
//
//var snake = Reptile(name: "Snake", sound: "Hiss", numberOfLegs: 0, breathesOxygen: true)
//print(snake.description())
//snake.makeSound()
//
//class Animal {
//    var name: String
//    var sound: String
//    var numberOfLegs: Int
//    var breathesOxygen: Bool = true
//    init(name: String, sound: String, numberOfLegs: Int, breathesOxygen: Bool) {
//        self.name = name
//        self.sound = sound
//        self.numberOfLegs = numberOfLegs
//        self.breathesOxygen = breathesOxygen
//    }
//    func makeSound() {
//        print(self.sound)
//    }
//    func description() -> String {
//        return "name: \(self.name) \nsound: \(self.sound) \nnumberOfLegs: \(self.numberOfLegs) \nbreathesOxygen: \(self.breathesOxygen)"
//    }
//}
//
//class Mammal: Animal {
//    let hasFurOrHair: Bool
//
//    init(hasFurOrHair: Bool, name: String, sound: String, numberOfLegs: Int) {
//        self.hasFurOrHair = hasFurOrHair
//        super.init(name: name, sound: sound, numberOfLegs: 4, breathesOxygen: true)
//    }
//
//    override func description() -> String {
//        return super.description() + "\nhasFurOrHair: \(self.hasFurOrHair)"
//    }
//}
//
//let cat = Mammal(hasFurOrHair: true, name: "Cat", sound: "Mew", numberOfLegs: 4)
//print(cat.description())
//var numbersArray = [2, 4, 6, 7]
//let myClosure = { (number: Int) -> Int in
//    let result = number * number
//    return result
//}
//
//let mappedNumbers = numbersArray.map(myClosure)
//
//var testNumbers = [2, 4, 6, 7]
////let mappedTestNumbers = testNumbers.map({ (number: Int) -> Int in
////    let result = number * number
////    return result
////})
////let mappedTestNumbers = testNumbers.map({ number in
////    number * number
////})
//let mappedTestNumbers = testNumbers.map { $0 * $0 }
//print(mappedTestNumbers)
//
//
//
//func buySomething(itemValueEntered itemValueField: String, cardBalance: Int) -> Int {
//    guard let itemValue = Int(itemValueField) else {
//        print("error in item value")
//        return cardBalance
//    }
//    let remainingBalance = cardBalance - itemValue
//    return remainingBalance
//}
//
//print(buySomething(itemValueEntered: "10", cardBalance: 50))
//print(buySomething(itemValueEntered: "blue", cardBalance: 50))
//
//func isThereAMatch(listOfNumbers: [Int], condition: (Int) -> Bool) -> Bool {
//    for item in listOfNumbers {
//        if condition(item) {
//            return true
//        }
//    }
//    return false
//}
//
//func oddNumber(number: Int) -> Bool {
//    return (number % 2) > 0
//}
//
//let numbersList = [2, 4, 6, 7]
//isThereAMatch(listOfNumbers: numbersList, condition: oddNumber)
//
//func makePi() -> (() -> Double) {
//    func generatePi() -> Double {
//        return 22.0 / 7.0
//    }
//    return generatePi
//}
//
//let pi = makePi()
//print(pi())
//func calculateMonthlyPayments(carPrice: Double, downPayment: Double,
//                              interestRate: Double, paymentTerm: Double) -> Double {
//    func loanAmount() -> Double {
//        return carPrice - downPayment
//    }
//    func totalInterest() -> Double {
//        return interestRate * paymentTerm
//    }
//    func numberOfMonths() -> Double {
//        return paymentTerm * 12
//    }
//    return ((loanAmount() + (loanAmount() * totalInterest() / 100)) / numberOfMonths())
//}
//
//
//calculateMonthlyPayments(carPrice: 50000, downPayment: 5000, interestRate: 3.5, paymentTerm: 7)
//

//func serviceCharge() {
//    let mealCost = 50
//    let serviceCharge = mealCost / 10
//    print("Service charge is \(serviceCharge)")
//}
//
//serviceCharge()
//
//func serviceCharge(mealCost: Int) -> Int {
//    return mealCost / 10
//}
//
//let serviceChargeAmount = serviceCharge(mealCost: 50)
//print(serviceChargeAmount)
//
//// custom argument label
//func serviceCharge(_ mealCost: Int) -> Int {
//    return mealCost / 10
//}
//
//let serviceChargeAmount2 = serviceCharge(50)
//print(serviceChargeAmount2)



//let theAnswerToTheUltimateQuestion = 42
//
////var greeting = "Hello, playground"
//
//var restaurantRating: Double = 3
////restaurantRating = "Good"
//
//let a = 12
//let b = 12.0
//let c = Double(a) + b
//
//var d = 1
//d += 2 // d = d + 2
//d -= 1 // d = d - 1
//
//let greeting = "Good" + " Morning"
//
//let rating = 3.5
//var ratingResult = "The restaurant rating is " + String(rating)
//ratingResult = "The restaurant rating is \(rating)"
//print(ratingResult)
//
//let isRestaurantOpen = true
//
//if isRestaurantOpen {
//    print("Restaurant is open.")
//}
//
//let isRestaurantFound = false
//
//if !isRestaurantFound {
//    print("Restaurant was not found")
//}
//
//let drinkingAgeLimit = 21
//let customerAge = 23
//
//if customerAge < drinkingAgeLimit {
//    print("Under age limit")
//} else {
//    print("Over age limit")
//}
//
//let trafficLightColor = "Yellow"
//
//switch trafficLightColor {
//case "Red":
//    print("Stop")
//case "Yellow":
//    print("Caution")
//case "Green":
//    print("Go")
//default:
//    print("Invalid color")
//}
//
//var spouseName: String?
//print(spouseName ?? "No value in spouseName")
//
//spouseName = "Nia"
//print(spouseName ?? "No value in spouseName")
//
//if let spouseTempVar = spouseName {
//    let greeting =  "Hello, " + spouseTempVar
//    print(greeting)
//} else {
//    print("No one")
//}
//
//let myRange = 10...20
//let myRange2 = 10..<20
//
//for number in myRange {
//    print(number)
//}
//
//for number in myRange2 {
//    print(number)
//}
//
//for number in (0...5).reversed() {
//    print(number)
//}
//
//var y = 50
//while y < 50 {
//    y += 5
//    print("y is \(y)")
//}
//
////var x = 50
////repeat {
////    x += 5
////    print("x is \(x)")
////} while x < 50
//print("-----------Array------------")
//
//var shoppingList = ["Egg", "Milk"]
//
//print(shoppingList.count)
//
//shoppingList.append("Cooking Oil")
//shoppingList = shoppingList + ["Chicken"]
//shoppingList.insert("Water", at: 1)
//
//shoppingList.remove(at: 1)
//let removeElement = shoppingList.removeLast()
//
//print("remove: \(removeElement)")
//
//print("-----------Dictionary------------")
//
//var contactList = ["Shah": "+6012345456789", "Aamir": "+02234546789"]
//print(contactList.count)
//print(contactList.isEmpty)
//
//contactList["Jane"] = "+0229876543"
//print(contactList["Shah"] ?? "No Value")
//
//var oldDictValue = contactList.removeValue(forKey: "Aamir")
//print(oldDictValue ?? "No Value")
//print(contactList.count)
//
//for (name, contactNumber) in contactList {
//    print("\(name): \(contactNumber)")
//}
//
//print("-----------Set------------")
//
//var movieGenres: Set = ["Horror", "Action", "Romantic Comedy"]
//
//print(movieGenres.count)
//print(movieGenres.isEmpty)
//
//movieGenres.insert("War")
//movieGenres.contains("War")
//
//var oldSetValue = movieGenres.remove("Action")
//print(oldSetValue ?? "No Value")
//
//for genre in movieGenres {
//    print(genre)
//}
//
//let movieGenres2: Set = ["SF", "War", "Fantasy"]
//
//movieGenres.union(movieGenres2)
//movieGenres.intersection(movieGenres2)
//var subSetMovieGenres = movieGenres.subtracting(movieGenres2)
//movieGenres.symmetricDifference(movieGenres2)
//
//movieGenres == movieGenres2
//subSetMovieGenres.isSubset(of: movieGenres)
//movieGenres.isSuperset(of: subSetMovieGenres)
