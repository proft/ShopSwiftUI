//
//  SignUp.swift
//  ShopSwiftUI
//
//  Created by Ivan Morgun on 11.05.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUp: View {
    @State private var username = ""
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
            
            Text("Sign up")
                .font(.title)
            
            Text("Enter your email address and password and continue shopping.")
                .font(.callout)
            
            TextField("Username ", text: $username)
                .padding(.horizontal)
                .frame(height: 60)
                .background(.gray.opacity(0.2))
                .clipShape(Capsule())
                .overlay {
                    Capsule()
                        .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                }
            
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
                signup()
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
                SignIn()
            } label: {
                Text("Already have an account? **SignIn**")
                    .frame(maxWidth: .infinity)
            }
            .foregroundStyle(.white)
        }
        .padding()
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
    }
    
    func signup() {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            isLoading = false
            
            if error != nil {
                print(error?.localizedDescription ?? "AUTH ERROR")
            } else {
                let db = Firestore.firestore()
                let data: [String: Any] = [
                    "username": username,
                    "email": email
                ]
                
                UserDefaults.standard.setValue(result?.user.uid, forKey: "uid")
                UserDefaults.standard.setValue(username, forKey: "username")
                UserDefaults.standard.setValue(email, forKey: "email")
                
                db.collection("users").addDocument(data: data)
                
                isSigned = true
            }
        }
    }
    
}

#Preview {
    SignUp()
}
