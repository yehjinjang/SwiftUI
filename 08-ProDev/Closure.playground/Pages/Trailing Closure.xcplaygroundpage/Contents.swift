
var a: () -> Void = { () -> Void in return print("Hello, world") }

a()

func simpleExample(closure: () -> Void) {
    print("1. Wake up")
    closure()
    print("4. Eat breakfast")
}

simpleExample() {
    print("---2. Go to bathroom")
    print("---3. Brush teeth")
}

func passParameters(closure: (Int, Int) -> Void) {
    print("First line")
    // 클로저의 반환값이 Void이므로 아무 값도 출력되지 않음
    let value = closure(4, 8)
    print("value: \(value) \(x)")
    print("Second line")
}

passParameters { x, y in
    print("-- Closure code beginning")
    print("\(x * y)")
    print("-- ending")
}

func returnValue(closure: (Int, Int) -> Int) {
    print("First line")
    let value = closure(5,2)
    print("\(value)")
    print("Second line")
}

returnValue { x, y in
    return x + y
}
