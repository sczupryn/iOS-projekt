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
    
    ///
    
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
                
                HStack {
                    ForEach (produkty, id: \.self) {
                        produkt in
                        Text(produkt)
                            .frame(width: 50, height: 50)
                            .scaleEffect(2.0)
                            .background(.gray)
                            .draggable(produkt)
                    }
                }
                
                VStack {
                    Text("Dodanych produktow: \(pickedProducts.count)")
                        .font(.title)
                    
                    DropProductsView(pickedProducts: $pickedProducts)
                        .frame(width: 200, height: 300)
                        .background(.red)
                        .dropDestination(for: String.self) {
                            item, location in
                            pickedProducts.append(contentsOf: item)
                            return true
                        }
                }
                
                
                
                
                
                
                
//                NavigationLink(destination: NewRecipe()) {
//                    Text("Nowy przepis")
                }
            }
            
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
