import SwiftUI

struct EditRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var recipe: Recipe  // Przepis do edycji
    
    @State private var name: String = ""
    @State private var instruction: String = ""
    @State private var difficulty: Int16 = 0
    @State private var preparationTime: Int16 = 0
    
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
                
                Section(header: Text("Poziom trudności")) {
                    Stepper(value: $difficulty, in: 0...10) {
                        Text("\(difficulty)")
                    }
                }
                
                Section(header: Text("Czas przygotowania (min)")) {
                    Stepper(value: $preparationTime, in: 0...300) {
                        Text("\(preparationTime) minut")
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
        difficulty = recipe.difficulty
        preparationTime = recipe.preparationTime
    }
    
    private func saveChanges() {
        recipe.name = name
        recipe.instruction = instruction
        recipe.difficulty = difficulty
        recipe.preparationTime = preparationTime
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            print("Błąd zapisu: \(nsError), \(nsError.userInfo)")
        }
    }
}
