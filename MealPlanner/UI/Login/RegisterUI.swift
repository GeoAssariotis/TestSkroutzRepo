//
//  RegisterUI.swift
//  MealPlanner
//
//  Created by linq20 on 21/3/25.
//

import SwiftUI

struct RegisterUI: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isPasswordVisible: Bool
    @State private var email: String = ""
    @State private var isValidEmail: Bool = true
    
    private var emailRegex: String {
        return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    }
    
    private func validateEmail() {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isValidEmail = emailTest.evaluate(with: email)
    }
    
    //    var body: some View {
    //        VStack {
    //            Image(systemName: "globe.europe.africa.fill")
    //                .resizable()
    //                .scaledToFit()
    //                .frame(width: 150, height: 150)
    //                .padding(.top, 50)
    //
    //            HStack {
    //                VStack {
    //                    TextField("Enter username", text: $username)
    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
    //                        .padding()
    //                        .frame(width: 300)
    //
    //                    HStack{
    //                        if isPasswordVisible {
    //                            TextField("Enter password", text: $password)
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
    //                                .padding()
    //                                .frame(width: 300)
    //                        } else {
    //                            SecureField("Enter password", text: $password)
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
    //                                .padding()
    //                                .frame(width: 300)
    //                        }
    //
    //                        Button(action: {
    //                            isPasswordVisible.toggle()
    //                        }) {
    //                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
    //                                .foregroundColor(.gray)
    //                                .padding(.trailing, 10)
    //                        }
    //                    }
    //                    .frame(width: 300)
    //
    //                    HStack {
    //                        if isPasswordVisible {
    //                            TextField("Confirm password", text: $confirmPassword)
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
    //                                .padding()
    //                                .frame(width: 300)
    //                        } else {
    //                            SecureField("Confirm password", text: $confirmPassword)
    //                                .textFieldStyle(RoundedBorderTextFieldStyle())
    //                                .padding()
    //                                .frame(width: 300)
    //                        }
    //
    //                        Button(action: {
    //                            isPasswordVisible.toggle()
    //                        }) {
    //                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
    //                                .foregroundColor(.gray)
    //                                .padding(.trailing, 10)
    //                        }
    //                    }
    //                    .frame(width: 300)
    //
    //                    Button(action: {
    //                        print("Register button pressed")
    //                    }) {
    //                        Text("Register")
    //                            .frame(maxWidth: .infinity)
    //                        //.font(.title)
    //                            .foregroundColor(.white)
    //                            .padding()
    //                            .background(Color.black)
    //                            .cornerRadius(10)
    //                            .padding()
    //                    }
    //                    .padding(.top, 50)
    //                }
    //            }
    //        }
    //    }
    var body: some View {
        VStack {
            Image(systemName: "globe.europe.africa.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("Username")
                        .font(.headline)
                        .padding(.top, 40)
                    
                    TextField("Enter username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    
                    Text("E-mail")
                        .font(.headline)
                        .padding(.top)
                    
                    TextField("Enter your email", text: $email)
                        .frame(width: 300)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: email) {
                            validateEmail()
                        }
                    
                    if !isValidEmail {
                        Text("Invalid email address")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Text("Password")
                        .font(.headline)
                        .padding(.top)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Enter password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                        } else {
                            SecureField("Enter password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text("Confirm Password")
                        .font(.headline)
                        .padding(.top)
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Confirm password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                        } else {
                            SecureField("Confirm password", text: $confirmPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.leading, 30)
                
                Spacer()
            }
            
            Button(action: {
                print("Register button pressed")
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                //.font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(30)
                    .padding()
            }
            .padding(.top, 50)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


#Preview {
    RegisterUI(username: .constant("mockUsername"),
               password: .constant("mockPassword"),
               confirmPassword: .constant("mockPassword"),
               isPasswordVisible: .constant(true))
}
