////
////  DropProductsView.swift
////  Przepisy
////
////  Created by student on 27/05/2025.
////
//
//import SwiftUI
//
//struct DropProductsView: View {
//    @Binding var pickedProducts: [String]
//    var body: some View {
//        VStack {
//            Text("Produkty: \(String(pickedProducts.count))")
//            HStack {
//                VStack {
//                    List {
//                        ForEach (pickedProducts, id: \.self) { product in
//                            Text(product)
//                                .frame(width: 40, height: 40)
//                                .background(.gray)
//                                .scaleEffect(0.8)
//                        }
//                        .onDelete {
//                            index in
//                            pickedProducts.remove(atOffsets: index)
//                        }
//                    }
//                }
//            }
//            .frame(height: 200).background(.gray)
//        }
//    }
//}
//
////#Preview {
////    DropProductsView(pickedProducts: .constant(["a", "b", "c"]))
////}
