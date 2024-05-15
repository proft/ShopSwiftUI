//
//  SignIn.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 09.05.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignIn: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var isSigned = false
    
    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image(systemName: "arrow.left")
                .imageScale(.large)
                .onTapGesture {
                    dismiss.wrappedValue.dismiss()
                }
            
            Text("Sign in")
                .font(.title)
            
            Text("Enter your email address and password and continue shopping.")
                .font(.callout)
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .padding(.horizontal)
                .frame(height: 60)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
                .overlay {
                    Capsule()
                        .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                }
            
            SecureField("Password", text: $password)
                .padding(.horizontal)
                .frame(height: 60)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
                .overlay {
                    Capsule()
                        .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                }
            
            Spacer()
            
            Button {
                signin()
            } label: {
                if isLoading {
                    ProgressView()
                } else {
                    Text("Continue")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(.red)
            .clipShape(Capsule())
            .foregroundStyle(.white)
            .navigationDestination(isPresented: $isSigned) {
                ContentView()
            }
            
            NavigationLink {
                SignUp()
            } label: {
                Text("Not having account? **SignUp**")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
        }
        .padding()
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
    
    func signin() {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print("AUTH ERROR \(String(describing: error?.localizedDescription))")
                withAnimation {
                    isLoading.toggle()
                }
            } else {
                isSigned = true
                let db = Firestore.firestore()
                db.collection("users").document(result?.user.uid ?? "").getDocument { doc, error in
                    if let doc = doc, doc.exists {
                        let name = doc.get("username") as? String ?? ""
                        let email = doc.get("email") as? String ?? ""
                        UserDefaults.standard.set(name, forKey: "username")
                        UserDefaults.standard.setValue(email, forKey: "email")
                        isLoading.toggle()
                    } else {
                        isLoading.toggle()
                        print("Doc doesn't exist")
                    }
                }
            }
        }
    }
}

#Preview {
    SignIn()
}
