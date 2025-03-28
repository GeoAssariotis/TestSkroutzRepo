import SwiftUI
import KeychainAccess

struct FirstLoginUI: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    
    @StateObject var loginViewModel: LoginViewModel
    
    init(networkClient: NetworkClient,keyChain: Keychain) {
        _loginViewModel = StateObject(wrappedValue: LoginViewModel(networkClient: networkClient, keyChain: keyChain))
    }
    
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
                            .padding(.top)
                            .frame(width: 300)
                        
                        Text("Password")
                            .font(.headline)
                            .padding(.top)
                        HStack {
                            if isPasswordVisible {
                                TextField("Enter password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.top)
                                    .frame(width: 300)
                            } else {
                                SecureField("Enter password", text: $password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.top)
                                    .frame(width: 300)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .padding(.top)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.leading, 30)
                    
                    Spacer()
                }
                
                // Submit button at the center
                Button(action: {
                    // Add your login action here
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
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1)) // Background color
        }
    }

#Preview {
    LoginUI(networkClient: MockNetworkClient(),keyChain: Keychain())
}
