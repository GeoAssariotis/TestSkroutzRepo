import Foundation

protocol NetworkClient {
    func login(email: String, password: String) async throws -> APISession
    func register(email: String, password: String) async throws -> APISession
    func fetchMeals(week: Int) async throws -> [Days]
    func favouriteMeal(mealName: String)
    func saveToken(token: String)
}
