//
//  MealDetailViewModel.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var mealDetails: MealDetails?
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    func fetchMealDetails() {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MealDetailsResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.mealDetails = decodedResponse.meals.first
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
