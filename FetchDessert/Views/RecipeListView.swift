//
//  RecipeListView.swift
//  Fetch Project Swift UI
//
//  Created by A.d. Ahmed on 4/29/23.
//

import SwiftUI

// A view that displays a list of meals and their images.
struct RecipeListView: View {
  // Creates a stateful instance of RecipeListViewModel.
  @StateObject var viewModel = RecipeListViewModel()
  var body: some View {
    NavigationView {
      List(viewModel.meals) { meal in
        NavigationLink(destination: MealDetailView(viewModel: MealDetailViewModel(meal: meal))) {
          HStack {
            // Asynchronously loads the image of the meal.
            AsyncImageView(imageURL: meal.imageURL)
            Text(meal.name)
          }
        }
      }
      .navigationTitle("Desserts")
      .onAppear {
        viewModel.fetchMeals()
      }
    }
  }
}

// Helper view for asynchronously loading images
struct AsyncImageView: View {
  @StateObject var imageLoader = ImageLoader()
  let imageURL: String
  var body: some View {
    // Asynchronously loads the image of the meal.
    Group {
      if let image = imageLoader.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
          .frame(width: 50, height: 50)
      } else {
        ProgressView()
          .frame(width: 50, height: 50)
      }
    }
    // Loads the image from the given URL.
    .onAppear {
      imageLoader.loadImage(from: imageURL)
    }
  }
}

// Helper class for asynchronously loading images
class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  func loadImage(from url: String) {
    guard let url = URL(string: url) else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, error == nil else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data)
      }
    }.resume()
  }
}

struct RecipeListView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView()
  }
}
