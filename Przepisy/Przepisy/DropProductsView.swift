//
//  DropProductsView.swift
//  Przepisy
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct DropProductsView: View {
    @Binding var pickedProducts: [String]
    var body: some View {
        VStack {
            List {
                ForEach (pickedProducts, id: \.self) { product in
                    Text(product)
                        .frame(width: 50, height: 50)
                        .background(.gray)
                        .scaleEffect(1.1)
                }
                .onDelete {
                    index in
                    pickedProducts.remove(atOffsets: index)
                }
            }
        }
    }
}

//#Preview {
//    DropProductsView(pickedProducts: .constant(["a", "b", "c"]))
//}
