//
//  ContentView.swift
//  Przepisy
//
//  Created by student on 20/05/2025.
//
import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.name, ascending: true)],
        animation: .default)
    private var recipes: FetchedResults<Recipe>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Shop.name, ascending: true)],
        animation: .default)
    private var shops: FetchedResults<Shop>
    
    @State private var showingAddRecipe = false
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
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
                    .onDelete(perform: deleteRecipe)
                }
                .listStyle(.plain)
                .navigationTitle("Przepisy")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingAddRecipe = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddRecipe) {
                    AddRecipeView()
            }
            .onAppear {
                if products.isEmpty {
                    addProducts()
                }
                if shops.isEmpty {
                    addShops()
                }
            }
        }
    }

    
    private func deleteRecipe(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("Błąd usuwania: \(error.localizedDescription)")
            }
        }
    }
    
    private func addProducts() {
        withAnimation {
            let newProduct1 = Product(context: viewContext)
            newProduct1.name = "Marchewka"
            newProduct1.calories = 41
            
            let newProduct2 = Product(context: viewContext)
            newProduct2.name = "Mleko"
            newProduct2.calories = 42
            
            let newProduct3 = Product(context: viewContext)
            newProduct3.name = "Cukier"
            newProduct3.calories = 387
            
            let newProduct4 = Product(context: viewContext)
            newProduct4.name = "Maka"
            newProduct4.calories = 364
            
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
    
    private func addShops() {
        withAnimation {
            let newShop1 = Shop(context: viewContext)
            newShop1.name = "ABC"
            newShop1.latitude = 51.250672
            newShop1.longitude = 22.575633
            for product in products {
                newShop1.addToProducts(product)
            }
            
            let newShop2 = Shop(context: viewContext)
            newShop2.name = "Groszek"
            newShop2.latitude = 51.250700
            newShop2.longitude = 22.595800
            newShop2.addToProducts(products[2])
            newShop2.addToProducts(products[3])

            
            let newShop3 = Shop(context: viewContext)
            newShop3.name = "Dino"
            newShop3.latitude = 51.250841
            newShop3.longitude = 22.575923
            newShop3.addToProducts(products[0])
            newShop3.addToProducts(products[1])
            
            let newShop4 = Shop(context: viewContext)
            newShop4.name = "Stokrotka"
            newShop4.latitude = 51.250841
            newShop4.longitude = 22.575923
            newShop4.addToProducts(products[0])
            newShop4.addToProducts(products[1])
            newShop4.addToProducts(products[2])
            
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
    //    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    //}

