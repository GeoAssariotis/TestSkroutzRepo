import Foundation
import SwiftUI

class MealPlannerViewModel: ObservableObject {
    
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @Published var mealsSection: [DailyMealListRowModel] = []
    @Published var isLoading: Bool = false
    var daysMealsSection: [MealListRowModel] = []

    
    var cachedMealListRowModel: Dictionary<Int,DailyMealListRowModel> = [:]
    
    @MainActor func fetchAllMeals(week: Int) async {
        
        mealsSection.removeAll()
            if let mealListRowModel = cachedMealListRowModel[week] {
                mealsSection.append(mealListRowModel)
            } else {
                await fetchMeals(week: week)
            }
    }
    
    @MainActor private func fetchMeals(week: Int) async {
        
        withAnimation {
            isLoading = true
        }
        do {
            let meals = try await networkClient.fetchMeals(week: week)
            for meal in meals {
                let dailyMealListRowModel = DailyMealListRowModel(id: UUID().hashValue, day: meal.formattedDate, name: meal.name, meals: meal.meals.unsafelyUnwrapped)
                mealsSection.append(dailyMealListRowModel)
//                cachedMealListRowModel[week] = mealListRowModel
            }
//            let mealListRowModel = MealListRowModel(id: UUID().hashValue, days: "", savedMealsNames: [], meals: meals)
            
        } catch {
            print(error)
        }
        withAnimation {
            isLoading = false
        }
    }
    
    @MainActor func saveMealAsFanourite(mealName: String, section: DailyMealListRowModel) async {
        
        let sectionIndex = mealsSection.firstIndex { planetSection in
            section.id == planetSection.id
        }
        if let sectionIndex {
            mealsSection[sectionIndex].savedMealsNames.append(mealName)
            cachedMealListRowModel[section.id] = mealsSection[sectionIndex]
        }
    }
    
    @MainActor func emptyFavouritePlanets(section: DailyMealListRowModel) async {
        
        let sectionIndex = mealsSection.firstIndex { mealSection in
            section.id == mealSection.id
        }
        if let sectionIndex {
            mealsSection[sectionIndex].savedMealsNames.removeAll()
            cachedMealListRowModel[section.id] = mealsSection[sectionIndex]
        }
    }
    
}
