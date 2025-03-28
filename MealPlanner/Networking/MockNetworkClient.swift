import Foundation

private var savedToken: String?

class MockNetworkClient: NetworkClient {
    
    private var savedToken: String?
    
    func login(email: String, password: String) async throws -> APISession {
        try await Task.sleep(nanoseconds: 500)
        return .init(token: "pipa")
    }
    
    func register(email: String, password: String) async throws -> APISession {
        try await Task.sleep(nanoseconds: 500)
        return .init(token: "pipa")
    }
    
    func fetchMeals(week: Int) async throws -> [Days] {
        return .init()
    }
    
    func favouriteMeal(mealName: String) {
    }
    
    func saveToken(token: String) {
        
    }
}
