//
//  Database.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 15.05.2024.
//

import SwiftUI
import FirebaseFirestore

class Database: ObservableObject {
    @Published var products = [ProductModel]()
    
    init() {
        fetchAll()
    }
    
    func fetchAll() {
        //products = ProductModel.samples
        let db = Firestore.firestore()
        db.collection("products").addSnapshotListener { snapshot, error in
            if let snapshot {
                for document in snapshot.documents {
                    self.products.append(ProductModel(
                        id: document.documentID,
                        title: document.get("title") as! String,
                        brand: document.get("brand") as! String,
                        description: document.get("description") as! String,
                        images: document.get("images") as! [String],
                        sizes: document.get("images") as! [Int],
                        reviews: [ReviewModel.sample],
                        price: document.get("price") as! Int))
                }
            }
        }
    }
}
