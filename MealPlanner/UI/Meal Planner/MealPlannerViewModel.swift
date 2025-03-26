import Foundation

class MealPlannerViewModel: ObservableObject {
    
    var networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
}
