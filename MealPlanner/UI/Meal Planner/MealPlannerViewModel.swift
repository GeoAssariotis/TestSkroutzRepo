import Foundation
import SwiftUI

class MealPlannerViewModel: ObservableObject {
    
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @Published var mealsSection: [MealListRowModel] = []
    @Published var isLoading: Bool = false
    
    var cachedMealListRowModel: Dictionary<Int,MealListRowModel> = [:]
    
    @MainActor func fetchAllMeals(endingPage: Int) async {
        
        mealsSection.removeAll()
        for week in endingPage-5..<endingPage {
            if let mealListRowModel = cachedMealListRowModel[week] {
                mealsSection.append(mealListRowModel)
            } else {
                await fetchMeals(week: week)
            }
        }
    }
    
    @MainActor private func fetchMeals(week: Int) async {
        
        withAnimation {
            isLoading = true
        }
        do {
            let meals = try await networkClient.fetchMeals(week: week)
            let mealListRowModel = MealListRowModel(id: UUID().hashValue, savedMealsNames: [], meals: meals)
            mealsSection.append(mealListRowModel)
            cachedMealListRowModel[week] = mealListRowModel
        } catch {
            print(error)
        }
        withAnimation {
            isLoading = false
        }
    }
    
    @MainActor func saveMealAsFanourite(mealName: String, section: MealListRowModel) async {
        
        let sectionIndex = mealsSection.firstIndex { planetSection in
            section.id == planetSection.id
        }
        if let sectionIndex {
            mealsSection[sectionIndex].savedMealsNames.append(mealName)
            cachedMealListRowModel[section.id] = mealsSection[sectionIndex]
        }
    }
    
    @MainActor func emptyFavouritePlanets(section: MealListRowModel) async {
        
        let sectionIndex = mealsSection.firstIndex { mealSection in
            section.id == mealSection.id
        }
        if let sectionIndex {
            mealsSection[sectionIndex].savedMealsNames.removeAll()
            cachedMealListRowModel[section.id] = mealsSection[sectionIndex]
        }
    }
    
}
