import SwiftUI

struct RecipeDetailView: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                Text(recipe.name ?? "Bez nazwy")
                    .font(.system(size: 28, weight: .bold))
                    .padding(.horizontal)

                GroupBox(label: Label("Trudność", systemImage: "flame")) {
                    Image(difficultyImageName(for: recipe.difficulty))
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .padding(.top, 4)
                }
                .padding(.horizontal)

                GroupBox(label: Label("Czas przygotowania", systemImage: "clock")) {
                    Text("\(recipe.preparationTime) minut")
                        .font(.body)
                        .padding(.top, 4)
                }
                .padding(.horizontal)

                GroupBox(label: Label("Składniki", systemImage: "cart")) {
                    if recipe.recipeProductsArray.isEmpty {
                        Text("Brak składników")
                            .padding(.top, 4)
                    } else {
                        ForEach(recipe.recipeProductsArray, id: \.self) { rp in
                            HStack {
                                Text(rp.product?.name ?? "Nieznany produkt")
                                Spacer()
                                Text("x\(rp.quantity)")
                                    .foregroundColor(.secondary)
                                    .padding(.top, 4)
                            }
                            Divider()
                        }
                    }
                }
                .padding(.horizontal)

                GroupBox(label: Label("Instrukcja przygotowania", systemImage: "list.bullet.clipboard")) {
                    Text(recipe.instruction ?? "")
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 4)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Szczegóły przepisu")
    }

    private func difficultyImageName(for difficulty: Int16) -> String {
        switch difficulty {
        case 0...3:
            return "easy"
        case 4...7:
            return "medium"
        default:
            return "hard"
        }
    }
}
