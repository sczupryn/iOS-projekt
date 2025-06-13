//import SwiftUI
//import CoreData
//
//struct RecipeListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Recipes.name, ascending: true)],
//        animation: .default)
//    private var recipes: FetchedResults<Recipes>
//
//    @State private var selectedRecipe: Recipes?
//    @State private var navigateToDetail = false
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(recipes) { recipe in
//                    NavigationLink(destination: RecipeDetailView(recipe: recipes)) {
//                        VStack(alignment: .leading) {
//                            Text(recipe.name ?? "")
//                                .font(.headline)
//                            Text("\(recipe.preparationTime) min | \(recipe.difficulty)")
//                                .font(.subheadline)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//                .onDelete(perform: deleteRecipe)
//            }
//            .listStyle(.plain)
//            .navigationTitle("Przepisy")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: addRecipe) {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .overlay(
//                ShakeDetectingView { showRandomRecipe() }
//            )
//            .background(
//                NavigationLink(
//                    destination: selectedRecipe.map { RecipeDetailView(recipe: $0) },
//                    isActive: $navigateToDetail
//                ) { EmptyView() }
//            )
//        }
//    }
//    
//    private func showRandomRecipe() {
//        guard !recipes.isEmpty else { return }
//        selectedRecipe = recipes.randomElement()
//        navigateToDetail = true
//    }
//    
//    private func addRecipe() {
//        withAnimation {
//            let recipe = Recipes(context: viewContext)
//            recipe.difficulty = 1
//            recipe.instruction = "Usmaż jajka"
//            recipe.name = "Jajecznica"
//            recipe.preparationTime = 10
//
//            do {
//                try viewContext.save()
//            } catch {
//                print("Błąd zapisu: \(error.localizedDescription)")
//            }
//        }
//    }
//    
//    private func deleteRecipe(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { recipes[$0] }.forEach(viewContext.delete)
//            do {
//                try viewContext.save()
//            } catch {
//                print("Błąd usuwania: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//// MARK: - Shake Detector
//struct ShakeDetectingView: UIViewControllerRepresentable {
//    var onShake: () -> Void
//
//    class Coordinator: NSObject {
//        var onShake: () -> Void
//
//        init(onShake: @escaping () -> Void) {
//            self.onShake = onShake
//        }
//    }
//
//    func makeUIViewController(context: Context) -> UIViewController {
//        let controller = ShakeDetectingViewController()
//        controller.onShake = context.coordinator.onShake
//        return controller
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(onShake: onShake)
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}
//
//class ShakeDetectingViewController: UIViewController {
//    var onShake: (() -> Void)?
//
//    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//        if motion == .motionShake {
//            onShake?()
//        }
//    }
//}
//
//#Preview {
//    RecipeListView()
//}
