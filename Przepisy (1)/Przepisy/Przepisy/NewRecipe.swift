//
//  NewRecipe.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct NewRecipe: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Products>
    
    @State private var name: String
    @State private var instruction: String
    @State private var ingredients: String
    @State private var difficulty: Int16
    @State private var preparationTime: Int16
    
    var body: some View {
        VStack {
            TextField("Nazwa przepisu", text: $name)
                .textFieldStyle(.roundedBorder)
            
        }
    }
}

//#Preview {
//    NewRecipe()
//}
