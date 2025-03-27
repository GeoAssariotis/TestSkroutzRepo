import Foundation

protocol NetworkClient {
    func login(username: String, password: String) async throws -> APISession
    func register(username: String, password: String) async throws -> APISession
//    func fetchMeals(week: String) async throws -> WeekPlan
//    func favouriteMeal(mealName: String) async throws -> String
//    func saveToken(token: String)
    
//    func login(username: String, password: String)
    func fetchMeals(week: Int) async throws -> [WeekPlan]
    func favouriteMeal(mealName: String)
    func saveToken(token: String)
}
