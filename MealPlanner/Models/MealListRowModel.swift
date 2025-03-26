import Foundation

struct MealListRowModel: Identifiable {
    let id: String
    var savedPlanetNames: [String] = []
    var meals: [Meals]
}
