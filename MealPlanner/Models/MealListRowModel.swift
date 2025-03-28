import Foundation

struct MealListRowModel: Identifiable {
    let id: Int
    let days: String
    var savedMealsNames: [String] = []
    var meals: [Days]
}

struct DailyMealListRowModel: Identifiable {
    let id: Int
    let day: String
    let name: String
    var savedMealsNames: [String] = []
    var meals: [Meal]
}
