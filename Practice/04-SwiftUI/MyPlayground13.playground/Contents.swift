//struct Address {
//    private var cityname: String = ""
//    private var cityname2: String = ""
//
//    var city: String {
//        get { cityname }
//        set { cityname = newValue.uppercased() }
//    }
//    var city2: String {
//        get { cityname2 }
//        set { cityname2 = newValue.lowercased() }
//    }
//}
//
//var address = Address()
//address.city = "London"
//address.city2 = "London"
//print("City: \(address.city), City2: \(address.city2)")



@propertyWrapper
struct FixCase {
    private(set) var value: String = ""
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }
    
    init(wrappedValue initialValue: String) {
        self.wrappedValue = initialValue
    }
}


struct Contact {
    @FixCase var name: String
    @FixCase var city: String
    @FixCase var country: String
}

var contact = Contact(name: "John Smith", city: "London", country: "United Kingdom")

print("\(contact.name), \(contact.city), \(contact.country)")

struct Address {
    private var cityname: String = ""
    
    var city: String {
        get { cityname }
        set { cityname = newValue.uppercased() }
    }
}

var address = Address()
address.city = "London"
print(address.city)


//정수형에만 해당되게 하는 프로퍼티를 다양한 타입의 변수를 저장할수있도록 설정해주는거
@propertyWrapper
struct MinMaxVal<V : Comparable>{
    var value : V
    let min : V
    let max : V

    init(wrappedValue: V, min: V, max: V){
        value = wrappedValue
        self.min = min
        self.max = max
    }
    var wrappedValue: V{
        get { return value }
        set {
            if newValue > max {
                value = max
            } else if newValue < min {
                value = min
            } else {
                value = newValue
            }
        }
    }
}
struct Demo {
    @MinMaxVal(min: 10, max:150) var value: Int = 100
    @MinMaxVal(min: "Apple", max: "Orange") var value2: String = ""
}

var demo = Demo()

demo.value2 = "Banana"

print(demo.value2)

demo.value2 = "Pear"

print(demo.value2)

