//
//  RecipeListViewModel.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import Foundation
import Combine

@MainActor
class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var cancellables = Set<AnyCancellable>()
    
    // Async/await version
    func fetchMeals() async {
        do {
            let url = API.mealsURL(category: "Dessert")
            let response: MealsResponse = try await NetworkManager.shared.fetch(url: url, decodingType: MealsResponse.self)
            self.meals = response.meals
        } catch {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    // Combine version
    func fetchMealsCombine() {
        let url = API.mealsURL(category: "Dessert")
        
        NetworkManager.shared.fetchPublisher(url: url, decodingType: MealsResponse.self)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Fetch failed: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                self.meals = response.meals
            }
            .store(in: &cancellables)
    }
}
