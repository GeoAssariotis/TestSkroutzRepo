import SwiftUI
import KeychainAccess

struct TestLoginUI: View {
    
    @StateObject var loginViewModel: LoginViewModel
    
    init(networkClient: NetworkClient, keyChain: Keychain) {
        _loginViewModel = StateObject(wrappedValue: LoginViewModel(networkClient: networkClient,keyChain: keyChain))
    }

    @State var username: String = "pariloas@curlybrac.com"
    @State var password: String = "4fY-kbH-bVE"
    @State var isPasswordVisible: Bool = false
    
//    var body: some View {
//        VStack {
//            Image(systemName: "app.logo") // Use your own image here
//                .resizable()
//                .scaledToFit()
//                .frame(width: 150, height: 150)
//                .padding(.top, 50)
//            
//            // Username and Password fields with show password button
//            TextField("Enter username", text: $username)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//                .frame(width: 300)
//            
//            ZStack(alignment: .trailing) {
//                if isPasswordVisible {
//                    TextField("Enter password", text: $password)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                        .frame(width: 300)
//                } else {
//                    SecureField("Enter password", text: $password)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()
//                        .frame(width: 300)
//                }
//                
//                Button(action: {
//                    isPasswordVisible.toggle()
//                }) {
//                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
//                        .foregroundColor(.gray)
//                        .padding(.trailing, 10)
//                }
//            }
//            .frame(width: 300)
//            
//            Button(action: {
//                print("Login button pressed")
//            }) {
//                Text("Submit")
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding(.top, 40)
//        }.scaledToFill()
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
                    }
                    .padding(.leading, 30)
                    
                    Spacer()
                }
                
                Button(action: {
                        Task {
                            await loginViewModel.performRegister(username: username, password: password)
                            await loginViewModel.performLogin(username: username, password: password)
                        }
                        
                }) {
                    if loginViewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                        //.font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(30)
                            .padding()
                    }
                }
                .padding(.top, 50)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

}


#Preview {
    TestLoginUI(networkClient: MainNetworkClient(), keyChain: Keychain())
}
