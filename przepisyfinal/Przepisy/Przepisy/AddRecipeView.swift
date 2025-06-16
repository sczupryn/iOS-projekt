import SwiftUI

struct SelectedProduct: Identifiable, Hashable {
    let id = UUID()
    let product: Product
    var quantity: Int16
}

struct AddRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var allProducts: FetchedResults<Product>

    @State private var name: String = ""
    @State private var instruction: String = ""
    @State private var difficulty: Double = 0.0
    @State private var preparationTime: Int16 = 0

    @State private var selectedProduct: Product?
    @State private var selectedProducts: [SelectedProduct] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nazwa przepisu")) {
                    TextField("Nazwa", text: $name)
                }
                Section(header: Text("Czas przygotowania")) {
                    TextField("Czas przygotowania (minuty)", value: $preparationTime, format: .number)
                }
                Section(header: Text("Poziom trudności \(Int(difficulty))")){
                    Slider(value: $difficulty, in: 0...10, step: 1)
                }
                Section(header: Text("Instrukcja")){
                    TextEditor(text: $instruction)
                        .frame(height: 100)
                }

                Section(header: Text("Dodaj składniki")) {
                    Picker("Produkt", selection: $selectedProduct) {
                        Text("Wybierz produkt").tag(Product?.none)
                        ForEach(allProducts, id: \.self) { product in
                            Text(product.name ?? "Brak nazwy").tag(Product?.some(product))
                        }
                    }

                    Button("Dodaj do przepisu") {
                        if let product = selectedProduct, !selectedProducts.contains(where: { $0.product == product }) {
                            selectedProducts.append(SelectedProduct(product: product, quantity: 1))
                            selectedProduct = nil
                        }
                    }
                    .disabled(selectedProduct == nil)
                }

                if !selectedProducts.isEmpty {
                    Section(header: Text("Wybrane składniki")) {
                        ForEach($selectedProducts) { $selected in
                            HStack {
                                Text(selected.product.name ?? "Nieznany produkt")
                                Spacer()
                                Stepper("Ilość: \(selected.quantity)", value: $selected.quantity, in: 1...99)
                                Button(role: .destructive) {
                                    selectedProducts.removeAll { $0.id == selected.id }
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }

                Section {
                    Button("Zapisz") {
                        saveRecipe()
                    }
                    .disabled(name.isEmpty || instruction.isEmpty || selectedProducts.isEmpty)
                }
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

    private func saveRecipe() {
        let newRecipe = Recipe(context: viewContext)
        newRecipe.name = name
        newRecipe.instruction = instruction
        newRecipe.difficulty = Int16(difficulty)
        newRecipe.preparationTime = preparationTime

        for selected in selectedProducts {
            let recipeProduct = RecipeProduct(context: viewContext)
            recipeProduct.product = selected.product
            recipeProduct.quantity = selected.quantity
            recipeProduct.recipe = newRecipe
            newRecipe.addToRecipeProducts(recipeProduct)
        }

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Błąd zapisu: \(error.localizedDescription)")
        }
    }
}
