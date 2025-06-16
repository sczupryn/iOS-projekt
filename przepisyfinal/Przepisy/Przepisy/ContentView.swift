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
    @State private var editingRecipe: Recipe? = nil
    @State private var showRandomDetail = false
    @State private var selectedRecipe: Recipe? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(recipes) { recipe in
                        HStack {
                            NavigationLink {
                                RecipeDetailView(recipe: recipe)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(recipe.name ?? "")
                                        .font(.headline)
                                    Text("\(recipe.preparationTime) min | \(recipe.difficulty)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            Button {
                                editingRecipe = recipe
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .onDelete(perform: deleteRecipe)
                }

                NavigationLink(
                    destination: selectedRecipe.map { RecipeDetailView(recipe: $0) },
                    isActive: $showRandomDetail
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .navigationTitle("Przepisy")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddRecipe = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRecipe) {
                AddRecipeView()
            }
            .sheet(item: $editingRecipe) { recipe in
                EditRecipeView(recipe: recipe)
            }
            .onAppear {
                if products.isEmpty {
                    addProducts()
                }
                if shops.isEmpty {
                    addShops()
                }
            }
            .overlay(
                ShakeDetectingView {
                    showRandomRecipe()
                }
                .frame(width: 0, height: 0)
            )
        }
    }

    private func showRandomRecipe() {
        if let random = recipes.randomElement() {
            selectedRecipe = random
            showRandomDetail = true
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
            let productData = [
                ("Marchewka", 41),
                ("Mleko", 42),
                ("Cukier", 387),
                ("Maka", 364)
            ]
            for (name, calories) in productData {
                let newProduct = Product(context: viewContext)
                newProduct.name = name
                newProduct.calories = Int16(calories)
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func addShops() {
        withAnimation {
            let shop1 = Shop(context: viewContext)
            shop1.name = "ABC"
            shop1.latitude = 51.250672
            shop1.longitude = 22.575633
            products.forEach { shop1.addToProducts($0) }

            let shop2 = Shop(context: viewContext)
            shop2.name = "Groszek"
            shop2.latitude = 51.250700
            shop2.longitude = 22.595800
            if products.count > 2 {
                shop2.addToProducts(products[2])
                shop2.addToProducts(products[3])
            }

            let shop3 = Shop(context: viewContext)
            shop3.name = "Dino"
            shop3.latitude = 51.250841
            shop3.longitude = 22.575923
            if products.count > 1 {
                shop3.addToProducts(products[0])
                shop3.addToProducts(products[1])
            }

            let shop4 = Shop(context: viewContext)
            shop4.name = "Stokrotka"
            shop4.latitude = 51.250841
            shop4.longitude = 22.575923
            if products.count > 2 {
                shop4.addToProducts(products[0])
                shop4.addToProducts(products[1])
                shop4.addToProducts(products[2])
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

class ShakeDetectingViewController: UIViewController {
    var onShake: (() -> Void)?

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            onShake?()
        }
    }
}

struct ShakeDetectingView: UIViewControllerRepresentable {
    var onShake: () -> Void

    func makeUIViewController(context: Context) -> ShakeDetectingViewController {
        let controller = ShakeDetectingViewController()
        controller.onShake = onShake
        return controller
    }

    func updateUIViewController(_ uiViewController: ShakeDetectingViewController, context: Context) {}
}
