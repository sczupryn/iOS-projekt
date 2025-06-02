//
//  SwiftMap.swift
//  rdprojekt
//
//  Created by student on 27/05/2025.
//

import SwiftUI
import MapKit


struct Store: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let products: [String]
}
struct SwiftMap: View {

    
    
    let stores = [
            Store(name: "Sklep1", coordinate: CLLocationCoordinate2D(latitude: 51.250672, longitude: 22.575633), products: ["Jabłka", "Chleb", "Mleko"]),
            Store(name: "Sklep2", coordinate: CLLocationCoordinate2D(latitude: 51.250700, longitude: 22.595800), products: ["Ser", "Masło", "Pomarańcze"])
        ]
    
    let defaultStore = Store(name: "Wybierz sklep", coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), products: [])
    
    let sklep1 = CLLocationCoordinate2D(latitude: 51.250672, longitude: 22.575633)
    
    let sklep2 = CLLocationCoordinate2D(latitude: 51.237594, longitude: 22.563602)
    
    @State var camera: MapCameraPosition = .automatic
    @State private var selectedStore: Store? = nil
    
        var body: some View {
            VStack {
                Map(position: $camera) {
                    ForEach(stores, id: \.name) { store in
                        Annotation(store.name, coordinate: store.coordinate) {
                            Button(action: {
                                selectedStore = store
                            }) {
                                VStack {
                                    Image(systemName: "building.fill")
                                        .foregroundColor(.blue)
                                    Text(store.name)
                                        .font(.caption)
                                }
                                .padding(5)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 3)
                            }
                        }
                    }
                }
                .frame(height: 400)
                
                Spacer() // Utrzymanie stałego odstępu
                
                VStack {
                    if let store = selectedStore {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            VStack {
                                                Text("Produkty w \(store.name)")
                                                    .font(.headline)
                                                    .padding()
                                                List(store.products, id: \.self) { product in
                                                    Text(product)
                                                }
                                            }
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .shadow(radius: 5)
                                            .padding()
                                        }
                    } else {
                                        Text("Wybierz sklep")
                                            .font(.title2)
                                            .foregroundColor(.gray)
                                            .padding()
                                            .transition(.opacity)
                                    }
                }
                .transition(.move(edge: .bottom))
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .padding()
            }

            }
}

#Preview {
    SwiftMap()
}
