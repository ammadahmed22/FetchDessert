//
//  RecipeListViewModel.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MealsResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.meals = decodedResponse.meals
                    }
                    return
                }
            }
            // Using print statement, incase of failure.
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
