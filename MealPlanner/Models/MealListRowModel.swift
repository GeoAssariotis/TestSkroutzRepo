import Foundation

struct MealListRowModel: Identifiable {
    let id: Int
    var savedMealsNames: [String] = []
    var meals: [WeekPlan]
}
