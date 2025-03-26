import SwiftUI
import KeychainAccess

struct OpeningUI: View {
    @State private var selectedTab = 0
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    
    @StateObject private var appDependencies = AppDependencies(networkclient: MainNetworkClient(), keyChain: Keychain())

    
    var body: some View {
        VStack {
            Picker("Form", selection: $selectedTab) {
                Text("Login").tag(0)
                Text("Registration").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if selectedTab == 0 {
                TestLoginUI(networkClient: appDependencies.networkclient, keyChain: appDependencies.keyChain)
            } else {
                RegisterUI(username: $username, password: $password, confirmPassword: $confirmPassword, isPasswordVisible: $isPasswordVisible)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

struct LoginView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "app.logo") // Use your own image here
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
            
            // Username and Password fields with show password button
            TextField("Enter username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 300)
            
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Enter password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                } else {
                    SecureField("Enter password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .frame(width: 300)
            
            Button(action: {
                print("Login button pressed")
            }) {
                Text("Submit")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 40)
        }
    }
}

struct RegisterView: View {
    @Binding var username: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isPasswordVisible: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "app.logo") // Use your own image here
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding(.top, 50)
            
            // Username, Password, and Confirm Password fields with show password button
            TextField("Enter username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 300)
            
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Enter password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                } else {
                    SecureField("Enter password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .frame(width: 300)
            
            ZStack(alignment: .trailing) {
                if isPasswordVisible {
                    TextField("Confirm password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                } else {
                    SecureField("Confirm password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(width: 300)
                }
                
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .frame(width: 300)
            
            Button(action: {
                print("Register button pressed")
            }) {
                Text("Register")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.top, 40)
        }
    }
}

struct OpeningUI_Previews: PreviewProvider {
    static var previews: some View {
        OpeningUI()
    }
}
