//
//  AddProductView.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//

import SwiftUI

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var Allproducts: FetchedResults<Product>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RecipeProduct.product, ascending: true)],
        animation: .default)
    private var recipeProducts: FetchedResults<RecipeProduct>
    
    @State private var name: String = ""
    @State private var instruction: String = ""
    @State private var difficulty: Int16?
    @State private var preparationTime: Int16?
    @State private var products: [Product] = []

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
                        ForEach (Allproducts, id: \.self) {
                            product in
                            Text(product.name ?? "")
                                .frame(width: 40, height: 40)
                                .background(.gray)
                                .draggable(product.name ?? "")
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
                 
                Button("Zapisz") {
                    addRecipe()
                }
                .disabled(instruction.isEmpty)
            }
            .navigationTitle("Nowy przepis")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") {
                        dismiss()
                    }
                }
            }
        }
    }
    private func addRecipe() {
        withAnimation {
            let newRecipe = Recipe(context: viewContext)
            newRecipe.name = name
            newRecipe.instruction = instruction
            newRecipe.difficulty = difficulty ?? 0
            newRecipe.preparationTime = preparationTime ?? 0
            
            let uniqueProducts = Array(Set(pickedProducts))
                for productName in uniqueProducts {
                    if let product = Allproducts.first(where: { $0.name == productName }) {
                        
                        let quantity = pickedProducts.filter { $0 == productName }.count
                        
                        let recipeProduct = RecipeProduct(context: viewContext)
                        recipeProduct.product = product
                        recipeProduct.recipe = newRecipe
                        recipeProduct.quantity = Int16(quantity)
                        newRecipe.addToProducts(recipeProduct)
                    }
                }
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

//#Preview {
//    AddRecipeView()
//}






/////
///
///
///@State private var pickedProducts: [Products] = []
//
//HStack {
//    ForEach(Allproducts, id: \.self) { produkt in
//        Text(produkt.name ?? "")
//            .frame(width: 100, height: 40)
//            .background(Color.gray)
//            .draggable(produkt) // Przeciąganie całego obiektu
//    }
//}

//VStack {
//    DropProductsView(pickedProducts: $pickedProducts)
//        .background(.gray)
//}
//.dropDestination(for: Products.self) { item, location in
//    // Dodajemy przeciągnięty obiekt produktu do pickedProducts
//    pickedProducts.append(item)
//    print("Dodano: \(item.name ?? "Nieznany produkt")") // Debugowanie
//    return true
//}

//
//struct DropProductsView: View {
//    @Binding var pickedProducts: [Products]
//
//    var body: some View {
//        VStack {
//            // Debugowanie: pokazujemy wszystkie produkty w pickedProducts
//            Text("Wybrane produkty: \(pickedProducts.map { $0.name ?? "Brak nazwy" }.joined(separator: ", "))")
//                .padding()
//
//            // Sprawdzamy, czy lista pickedProducts nie jest pusta
//            if pickedProducts.isEmpty {
//                Text("Brak wybranych produktów")
//                    .foregroundColor(.gray)
//            } else {
//                ForEach(pickedProducts, id: \.self) { product in
//                    Text(product.name ?? "Brak nazwy") // Wyświetlamy nazwę produktu
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//
//
//HStack {
//    ForEach(Allproducts, id: \.self) { produkt in
//        Text(produkt.name ?? "")
//            .frame(width: 100, height: 40)
//            .background(Color.gray)
//            .draggable(produkt) // Zmieniamy to na obiekt typu `Products`
//    }
//}
//
//VStack {
//    DropProductsView(pickedProducts: $pickedProducts)
//        .background(.gray)
//}
//.dropDestination(for: Products.self) { item, location in
//    pickedProducts.append(item) // Dodajemy obiekt `produkt`
//    print("Dodano: \(item.name ?? "Nieznany produkt")") // Debugowanie
//    return true
//}
