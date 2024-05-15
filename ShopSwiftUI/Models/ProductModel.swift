//
//  ProductModel.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 14.05.2024.
//

import Foundation

struct ProductModel: Identifiable, Hashable {
    var id: String
    var title: String
    var brand: String
    var description: String
    var images: [String]
    var sizes: [Int]
    var reviews: [ReviewModel]
    var price: Int
}

struct ReviewModel: Identifiable, Hashable {
    var id: UUID = .init()
    var username: String
    var image: String
    var review: String
    var rating: Int
}

extension ProductModel {
    static var samples: [ProductModel] {
        return [
            ProductModel(id: UUID().uuidString, title: "Ware 1", brand: "circle", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", images: ["https://prd.place/300", "https://prd.place/300"], sizes: [39, 40, 41], reviews: [ReviewModel.sample], price: 1500),
            
            ProductModel(id: UUID().uuidString, title: "Ware 2", brand: "shield", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", images: ["https://prd.place/300", "https://prd.place/300"], sizes: [42, 43, 44], reviews: [ReviewModel.sample], price: 2500)
        ]
    }
}

extension ReviewModel {
    static var sample: ReviewModel {
        .init(username: "Joe", image: "https://i.pravatar.cc/300", review: "Totally great", rating: 5)
    }
}
