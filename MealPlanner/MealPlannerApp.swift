import SwiftUI
import KeychainAccess

@main
struct MealPlannerApp: App {
    @StateObject private var appDependencies = AppDependencies(networkclient: MainNetworkClient(), keyChain: Keychain())
    
    var body: some Scene {
        WindowGroup {
            if shouldShowLogin()
            {
                OpeningUI(networkClient: appDependencies.networkclient, keyChain: appDependencies.keyChain)
            } else {
                MealPlannerUI(networkClient: appDependencies.networkclient)
                    .environmentObject(appDependencies)
                    .onAppear{
                        appDependencies.networkclient.saveToken(token: try! appDependencies.keyChain.get("token")!)
                    }
            }
        }
    }
    
    func shouldShowLogin() -> Bool {
        do {
            if try appDependencies.keyChain.contains("token") {
                return false
            } else {
                return true
            }
        } catch {
            return true
        }
    }
}
