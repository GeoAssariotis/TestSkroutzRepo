import Foundation
import KeychainAccess

class AppDependencies: ObservableObject {
    
    let networkclient: any NetworkClient
    var keyChain: Keychain

    init(networkclient: any NetworkClient, keyChain: Keychain) {
        self.networkclient = networkclient
        self.keyChain = keyChain
    }
}
