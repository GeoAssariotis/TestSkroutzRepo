import Foundation

struct WeekPlan: Decodable, Identifiable {
    
    var id: Int
    var days: [Days]
    
    enum CodingKeys: String, CodingKey {
        case id, days
    }
}
    
    struct Days: Decodable, Identifiable {
        
        var id: Int
        let name: String
        let formattedDate: String
        let meals: [Meal]?
        
        enum CodingKeys: String, CodingKey {
            case id, name, meals
            case formattedDate = "formatted_date"
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
