//
//  AddProductView.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipes.name, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipes>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Products>
    
    @State private var name: String = ""
    @State private var instruction: String = ""
    @State private var ingredients: String = ""
    @State private var difficulty: Int16?
    @State private var preparationTime: Int16?
    
    let produkty: [String] = ["p1", "p2", "p3", "p4"]
    @State var pickedProducts: [String] = []
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text("Nazwa przepisu")
                    TextField("Nazwa", text: $name)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                
                HStack {
                    Text("Poziom trudnosci")
                    TextField("Trudnosc", value: $difficulty, format: .number)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                
                HStack {
                    Text("Czas przygotowania")
                    TextField("Czas", value: $preparationTime, format: .number)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack {
                    Text("Przepis")
                    TextEditor(text: $instruction)
                        .foregroundColor(.black)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                
                VStack {
                    HStack {
                        ForEach (produkty, id: \.self) {
                            produkt in
                            Text(produkt)
                                .frame(width: 40, height: 40)
                                .background(.gray)
                                .draggable(produkt)
                        }
                    }
                    VStack {
                        DropProductsView(pickedProducts: $pickedProducts)
                            .background(.gray)
                    }
                    .dropDestination(for: String.self) {
                        item, location in
                        pickedProducts.append(contentsOf: item)
                        return true
                    }
                }
                .padding()
                    
            }
                
//                NavigationLink(destination: NewRecipe()) {
//                    Text("Nowy przepis")
        }
    }
    private func addProducts() {
        withAnimation {
            let newProduct = Products(context: viewContext)
            newProduct.name = name
//            newProduct.
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    AddProductView()
}
