import SwiftUI

struct EditRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @ObservedObject var recipe: Recipe

    @State private var name: String = ""
    @State private var instruction: String = ""
    @State private var difficulty: Double = 0.0
    @State private var preparationTime: Int16 = 0
    @State private var productQuantities: [RecipeProduct: Int16] = [:]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nazwa przepisu")) {
                    TextField("Nazwa", text: $name)
                }

                Section(header: Text("Instrukcja")) {
                    TextEditor(text: $instruction)
                        .frame(height: 150)
                }

                Section(header: Text("Poziom trudności \(Int(difficulty))")) {
                    Slider(value: $difficulty, in: 0...10, step: 1)
                }

                Section(header: Text("Czas przygotowania (min)")) {
                    Stepper(value: $preparationTime, in: 0...300) {
                        Text("\(preparationTime) minut")
                    }
                }

                Section(header: Text("Składniki")) {
                    ForEach(Array(productQuantities.keys), id: \.self) { rp in
                        HStack {
                            Text(rp.product?.name ?? "Nieznany produkt")
                            Spacer()
                            Stepper("Ilość: \(productQuantities[rp] ?? 0)", value: Binding(
                                get: { productQuantities[rp] ?? 0 },
                                set: { productQuantities[rp] = $0 }
                            ), in: 1...99)
                        }
                    }
                }

                Section {
                    Button("Zapisz") {
                        saveChanges()
                    }
                    .disabled(name.isEmpty || instruction.isEmpty)
                }
            }
            .navigationTitle("Edytuj przepis")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Anuluj") {
                        dismiss()
                    }
                }
            }
            .onAppear(perform: loadRecipeData)
        }
    }

    private func loadRecipeData() {
        name = recipe.name ?? ""
        instruction = recipe.instruction ?? ""
        difficulty = Double(recipe.difficulty)
        preparationTime = recipe.preparationTime

        for rp in recipe.recipeProductsArray {
            productQuantities[rp] = rp.quantity
        }
    }

    private func saveChanges() {
        recipe.name = name
        recipe.instruction = instruction
        recipe.difficulty = Int16(difficulty)
        recipe.preparationTime = preparationTime

        for (rp, quantity) in productQuantities {
            rp.quantity = quantity
        }

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Błąd zapisu: \(error.localizedDescription)")
        }
    }
}
