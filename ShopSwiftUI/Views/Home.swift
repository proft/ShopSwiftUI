//
//  Home.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 14.05.2024.
//

import SwiftUI

struct Home: View {
    @State var selectedCategory = "All"
    @State var products = [ProductModel]()//.samples
    @State var product: ProductModel? = nil
    @State var showProduct = false
    
    @StateObject var db = Database()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("**Shape**\nCollections")
                            .font(.largeTitle)
                        
                        Spacer()
                        
                        Image(systemName: "bell")
                            .padding(.vertical, 25)
                            .padding(.horizontal, 16)
                            .imageScale(.large)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.black.opacity(0.05), lineWidth: 3)
                            }
                    }
                    
                    categoriesView
                        .zIndex(1)
                    
                    productsView
                        .fullScreenCover(isPresented: $showProduct) {
                            Product(data: product ?? ProductModel.samples[0])
                        }
                }
                .padding()
                .onAppear {
                    products = db.products
                }
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.light)
    }
    
    var categoriesView: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(BrandModel.samples, id: \.id) { brand in
                    HStack {
                        if !brand.icon.isEmpty {
                            Image(systemName: brand.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                        }
                        
                        if selectedCategory == brand.title || brand.title == "All" {
                            Text(brand.title)
                        }
                    }
                    .foregroundStyle(selectedCategory == brand.title ? .white : .black)
                    .padding()
                    .background(selectedCategory == brand.title ? .black : .gray.opacity(0.08))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation {
                            selectedCategory = brand.title
                            
                            if brand.title == "All" {
                                products = db.products
                            } else {
                                products = db.products.filter({ $0.brand == brand.title })
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var productsView: some View {
        VStack {
            ForEach(products, id: \.id) { item in
                VStack {
                    AsyncImage(url: URL(string: item.images[0])) { img in
                        img
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                    .clipShape(Rectangle())
                    
                    Text(item.title)
                        .font(.headline.bold())
                    
                    Text("$\(item.price)")
                        .font(.callout)
                }
                .padding(.bottom)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .onTapGesture {
                    product = item
                    showProduct = true
                }
            }
        }
        .zIndex(0)
    }
}

#Preview {
    Home()
}
