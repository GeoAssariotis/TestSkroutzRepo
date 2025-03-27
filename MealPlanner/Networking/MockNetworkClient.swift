import Foundation

private var savedToken: String?

class MockNetworkClient: NetworkClient {
    
    private var savedToken: String?
    
    func login(username: String, password: String) async throws -> APISession {
        try await Task.sleep(nanoseconds: 500)
        return .init(token: "pipa")
    }
    
    func register(username: String, password: String) async throws -> APISession {
        try await Task.sleep(nanoseconds: 500)
        return .init(token: "pipa")
    }
    
    func fetchMeals(week: Int) async throws -> [WeekPlan] {
        return []
    }
    
    func favouriteMeal(mealName: String) {
    }
    
    func saveToken(token: String) {
        
    }
}
