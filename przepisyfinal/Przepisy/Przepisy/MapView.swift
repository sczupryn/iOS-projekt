////
////  MapView.swift
////  Przepisy
////
////  Created by student on 10/06/2025.
////
//
//import SwiftUI
//import MapKit
// 
//struct MapView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
// 
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Shop.name, ascending: true)],
//        animation: .default)
//    
//    private var shops: FetchedResults<Shop>
//    @State var camera: MapCameraPosition = .automatic
//    
//    @State private var selectedShop: Shop? = nil
// 
//    var body: some View {
//        NavigationView{
//            VStack {
//                Map(position: $camera) {
//                    ForEach(shops, id: \.name) { shop in
//                        Annotation(shop.name, coordinate: shop.coordinate) {
//                            Button(action: {
//                                selectedShop = shop
//                            }) {
//                                VStack {
//                                    Image(systemName: "building.fill")
//                                        .foregroundColor(.blue)
//                                    Text(shop.name)
//                                        .font(.caption)
//                                }
//                                .padding(5)
//                                .background(Color.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 8))
//                                .shadow(radius: 3)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.blue, lineWidth: 2)
//                                )
//                                
//                            }
//                        }
//                    }
//                }
//                .frame(height: 400)
//                
//                Spacer()
//                
//                VStack {
//                    if let shop = selectedShop {
//                        withAnimation(.easeInOut(duration: 0.5)) {
//                            VStack {
//                                Text("Produkty w \(shop.name)")
//                                    .font(.headline)
//                                    .padding()
//                                List(shop.products, id: \.self) { product in
//                                    Text(product)
//                                }
//                            }
//                            .background(Color.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 10))
//                            .shadow(radius: 5)
//                            .padding()
//                        }
//                    } else {
//                        Spacer()
//                        Text("Wybierz sklep")
//                            .font(.title2)
//                            .foregroundColor(.gray)
//                            .padding(10)
//                            .background(Color.white)
//                            .clipShape(RoundedRectangle(cornerRadius: 8))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.gray, lineWidth: 2)
//                            )
//                        
//                        Spacer()
//                        
//                    }
//                }
//                .transition(.move(edge: .bottom))
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .shadow(radius: 5)
//                .padding()
//            }
//            
//        }
//        .navigationTitle("Sklepy")
//    }
//}
//
//
////#Preview {
////    MapView()
////}
//
//
//  MapView.swift
//  Przepisy
//
//  Created by student on 10/06/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Shop.name, ascending: true)],
        animation: .default)
    private var shops: FetchedResults<Shop>

    @State private var camera: MapCameraPosition = .automatic
    @State private var selectedShop: Shop? = nil

    var body: some View {
        NavigationStack {
            VStack {
                mapSection
                detailsSection
            }
            .navigationTitle("Sklepy")
            .animation(.easeInOut(duration: 0.5), value: selectedShop)
        }
    }

    private var mapSection: some View {
        Map(position: $camera) {
            ForEach(shops, id: \.self) { shop in
                if let coordinate = shop.coordinate {
                    Annotation(shop.name ?? "Sklep", coordinate: coordinate) {
                        annotationButton(for: shop)
                    }
                }
            }
        }
        .frame(height: 400)
    }

    private func annotationButton(for shop: Shop) -> some View {
        Button {
            selectedShop = shop
        } label: {
            VStack {
                Image(systemName: "building.fill")
                    .foregroundColor(.blue)
                Text(shop.name ?? "Nieznany")
                    .font(.caption)
            }
            .padding(5)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .shadow(radius: 3)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.blue, lineWidth: 2)
            )
        }
    }

    private var detailsSection: some View {
        VStack {
            if let shop = selectedShop {
                VStack {
                    Text("Produkty w \(shop.name ?? "sklepie")")
                        .font(.headline)
                        .padding()
                    List(shop.productNames, id: \.self) { product in
                        Text(product)
                    }
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .padding()
            } else {
                Spacer()
                Text("Wybierz sklep")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                Spacer()
            }
        }
        .transition(.move(edge: .bottom))
        .padding()
    }
}
