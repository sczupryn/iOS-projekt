//
//  RecipeListView.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel = RecipeViewModel()
    let recipe1 = Recipe(name: "Makaron Carbonara", preparationTime: 20, difficulty: 5, instruction: "nie wiem zrob se", ingredients: "jajka")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading) {
                            Text(recipe.name ?? "")
                                .font(.headline)
                            Text("\(recipe.preparationTime) min | \(recipe.difficulty)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { viewModel.recipes[$0] }.forEach(viewModel.deleteRecipe)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Przepisy")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
}

        
