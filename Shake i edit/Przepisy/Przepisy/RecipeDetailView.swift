//
//  RecipeDetailView.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

//import SwiftUI
//
//struct RecipeDetailView: View {
//    let recipe: Recipe
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                Text(recipe.name ?? "")
//                    .font(.largeTitle)
//                Text("Czas: \(recipe.preparationTime) min")
//                Text("Trudność: \(Int16(recipe.difficulty))")
//                
//                Text("Składniki")
//                    .font(.headline)
//                Text(recipe.ingredients ?? "")
//                
//                Text("Instrukcja")
//                    .font(.headline)
//                Text(recipe.instruction ?? "")
//            }
//            .padding()
//        }
//        .navigationTitle("Szczegóły")
//    }
//}
//
//#Preview {
//    RecipeDetailView(recipe: Recipe())
//}


import SwiftUI


struct RecipeDetailView: View {
    var recipe: Recipe
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RecipeProduct.quantity, ascending: true)],
        animation: .default)
    
    
    
    private var recipeProducts: FetchedResults<RecipeProduct>
    var body: some View {
        NavigationView{
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Nazwa przepisu
                    Text(recipe.name ?? "Bez nazwy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    // Trudność
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Trudność")
                            .font(.headline)
                        Text(
                            {
                                switch recipe.difficulty {
                                case 0...3: return "Łatwy"
                                case 4...7: return "Średni"
                                default: return "Trudny"
                                }
                            }()
                        )
                        .font(.body)
                    }
                    
                    Divider()
                    
                    // Czas przygotowania
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Czas przygotowania")
                            .font(.headline)
                        Text("\(recipe.preparationTime) minut")
                            .font(.body)
                    }
                    
                    Divider()
                    
                    // Produkty
                    //VStack(alignment: .leading, spacing: 8) {
                    //    Text("Produkty")
                    //        .font(.headline)
                    //    ForEach((recipe.products as? Set<RecipeProduct> ?? []).sorted { $0.product?.name ?? "" < $1.product?.name ?? "" }) { recipeProduct in
                    //        HStack {
                    //            Text(recipeProduct.product?.name ?? "Nieznany produkt")
                    //            Spacer()
                    //            Text("\(recipeProduct.quantity)")
                    //        }
                    //        .padding(.vertical, 4)
                    //    }
                    // }
                    
                    Divider()
                    
                    // Instrukcja przygotowania
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Instrukcja przygotowania")
                            .font(.headline)
                        Text(recipe.instruction ?? "")
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
//                    NavigationLink(destination: MapView()) {
//                        Text("Pokaż sklepy na mapie")
//                            .font(.headline)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
                    .padding()
                }
            }
        }
    }
}
 

 

