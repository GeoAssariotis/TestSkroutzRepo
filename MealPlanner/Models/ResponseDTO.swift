import Foundation

struct WeekPlan: Decodable {
    
    var day: String
    var meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case day, meals
    }
}

struct Meal: Decodable, Identifiable {
    
    var id: Int
    var isFavourite: Bool? = false
    let name: String
    let description: String?
    let kcal: Int?
    let isVegan: Bool?
    let isGlutenFree: Int?

    
    enum CodingKeys: String, CodingKey {
        case id, name, isFavourite, description, kcal, isVegan, isGlutenFree
        
    }
}
