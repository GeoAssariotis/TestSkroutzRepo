import Foundation
import KeychainAccess

class LoginViewModel: ObservableObject {
    
    var networkClient: NetworkClient
    var keyChain: Keychain
    
    init(networkClient: NetworkClient, keyChain: Keychain) {
        self.networkClient = networkClient
        self.keyChain = keyChain
    }
    
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    @Published var isLoginSuccessful: Bool = false
    
    @MainActor func performLogin(username: String, password: String ) async {
        isLoading = true
        do {
            let session = try await networkClient.login(username: username, password: password)
            keyChain["token"] = session.token
            isLoginSuccessful = true
        } catch {
            isError = true
        }
        isLoading = false
    }
    
    @MainActor func performRegister(username: String, password: String ) async {
        isLoading = true
        do {
            let session = try await networkClient.register(username: username, password: password)
            keyChain["token"] = session.token
            isLoginSuccessful = true
        } catch {
            isError = true
        }
        isLoading = false
    }
}
