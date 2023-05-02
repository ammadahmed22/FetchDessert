//
//  RecipeListViewTests.swift
//  Fetch Project Swift UITests
//
//  Created by A.d. Ahmed on 4/29/23.
//

import XCTest

@testable import FetchDessert

class RecipeListViewTests: XCTestCase {
    func testFetchMeals() {
        let expectation = self.expectation(description: "Fetch meals")
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                    XCTAssertEqual(decodedResponse.meals.count, 64, "Unexpected number of meals")
                    expectation.fulfill()
                }
            }
        }
        task.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}

