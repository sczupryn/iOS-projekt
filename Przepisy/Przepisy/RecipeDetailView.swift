//
//  RecipeDetailView.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name ?? "")
                    .font(.largeTitle)
                Text("Czas: \(recipe.preparationTime) min")
                Text("Trudność: \(Int16(recipe.difficulty))")
                
                Text("Składniki")
                    .font(.headline)
                Text(recipe.ingredients ?? "")
                
                Text("Instrukcja")
                    .font(.headline)
                Text(recipe.instruction ?? "")
            }
            .padding()
        }
        .navigationTitle("Szczegóły")
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe())
}



