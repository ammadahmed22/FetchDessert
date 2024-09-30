//
//  MealDetailViewModel.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetails: MealDetails?
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    func fetchMealDetails() async {
        do {
            let url = API.mealDetailsURL(idMeal: meal.idMeal)
            let response: MealDetailsResponse = try await NetworkManager.shared.fetch(url: url, decodingType: MealDetailsResponse.self)
            self.mealDetails = response.meals.first
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
}
