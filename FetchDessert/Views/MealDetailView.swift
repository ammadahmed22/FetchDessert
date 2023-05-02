//
//  MealDetailView.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                mealImageView
                Text(viewModel.meal.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                if let mealDetails = viewModel.mealDetails {
                    let ingredientsArray = mealDetails.ingredients.map { (ingredient, measurement) -> (String, String) in
                        return (ingredient, measurement)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients:")
                            .font(.headline)
                        ForEach(ingredientsArray, id: \.0) { (ingredient, measurement) in
                            Text("- \(ingredient) (\(measurement))")
                        }
                        Divider()
                        Text("Instructions:")
                            .font(.headline)
                        Text(mealDetails.instructions)
                    }
                    .padding(.horizontal)
                } else {
                    ProgressView()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMealDetails()
        }
    }
    
    private var mealImageView: some View {
        Group {
            if let imageURL = URL(string: viewModel.meal.imageURL) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(maxWidth: .infinity)
                .aspectRatio(1.5, contentMode: .fill)
                .clipped()
            } else {
                Image(systemName: "photo")
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1.5, contentMode: .fill)
                    .clipped()
            }
        }
    }
}
