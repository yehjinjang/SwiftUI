import Foundation
import Combine

Just(42)
    .print()
    .sink{ value in
        print("Received \(value)")
    }

["Pepperoni", "Mushrooms", "Onions"].publisher
    .sink { topping in
        print("\(topping) is a favorite topping")
    }

// 문자열 퍼블리시

"Combine".publisher
    .sink { value in
        print("Hello, \(value)")
    }

// 한번에 출력하고 싶을때
Just("Combine")
    .sink { value in
        print("Hello, \(value)")
    }
