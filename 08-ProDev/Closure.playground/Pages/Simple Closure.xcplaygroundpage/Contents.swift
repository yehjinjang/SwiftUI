import UIKit

// 전통적인 함수 정의
func descriptiveName() {
    print("Run!")
}

// 전통적인 함수 실행
descriptiveName()

func multiplyBy2 (x: Int) -> Int {
    return x * 2
}

print(multiplyBy2(x: 4))
print(multiplyBy2(x: 17))

let y = { (x: Int) -> Int in return x * 2 }

print(y(4))
print(y(17))

// 클로저 인풋, 아웃풋 인자 생략
let z = { x in return x * 2 }

print(z(4))
print(z(17))

// return 키워드 생략
let w = { x in x * 2}

print(w(4))
print(w(17))

// 인풋 arguments 이름 생략
let v = { $0 * 2 }

print(v(4))
print(v(17))

func addNumbers (x: Int, y: Int) -> Int {
    return x + y
}

// 인풋 인자 타입 생략
let a = { (x, y) -> Int in return x + y }

print(a(4,5))
print(a(17,19))

// return 타입 생략
let b = { (x: Int, y: Int) in return x + y }

print(b(4,5))
print(b(17,19))

let c = { (x: Int, y: Int) in x + y }

print(c(4,5))
print(c(17,19))

// 모호성이 있는 경우, 매개변수의 데이터 유형을 명시적으로 정의해야함.
let d = { $0 as Int + $1 as Int }

print(d(4,5))
print(d(17,19))

// 데이터로서의 클로저
print("-----------------")
print(d(4,5))
print(d(1, d(4,5)))
