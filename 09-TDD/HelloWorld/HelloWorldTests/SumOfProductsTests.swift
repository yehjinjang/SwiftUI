//
//  SumOfProductsTests.swift
//  HelloWorldTests
//
//  Created by Jungman Bae on 7/10/24.
//

import XCTest

struct Product {
    let category: String
    let price: Double
}

func sumOf(_ products: [Product], withCategory category: String) -> Double {
    return products
        .filter { product in product.category == category }
        .reduce(0.0) { currentSum, product in  currentSum + product.price }
}

final class SumOfProductsTests: XCTestCase {
    func testSumOfEmptyArrayIsZero() {
        let category = "books"
        let products = [Product]()
        let sum = sumOf(products, withCategory: category)
        XCTAssertEqual(sum, 0)
    }
    func testSumOfOneItemIsItemPrice() {
        let category = "books"
        let products = [Product(category: category, price: 3)]
        let sum = sumOf(products, withCategory: category)
        XCTAssertEqual(sum, 3)
    }
    func testSumisSumOfItemsPricesForGivenCategory() {
        let category = "books"
        let products = [
            Product(category: category, price: 3),
            Product(category: "movies", price: 2),
            Product(category: category, price: 1)
        ]
        let sum = sumOf(products, withCategory: category)
        XCTAssertEqual(sum, 4)
    }
}
