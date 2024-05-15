//
//  BrandModel.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 13.05.2024.
//

import Foundation

struct BrandModel: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var icon: String
}

extension BrandModel {
    static var samples: [BrandModel] = [
        .init(title: "All", icon: ""),
        .init(title: "Circle", icon: "circle"),
        .init(title: "Square", icon: "square"),
        .init(title: "Shield", icon: "shield")
    ]
}
