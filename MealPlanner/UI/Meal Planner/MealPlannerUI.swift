import SwiftUI

struct MealPlannerUI: View {
    
    @StateObject var viewModel: MealPlannerViewModel
    @State var endingPage = 1
    @State var mealPicked : Meal?
    @State var isPresented = false
    private static let stepper = 1
    @State private var selectedIndexes: (sectionIndex: Int,planetIndex: Int) = (0,0)


    init(networkClient: NetworkClient) {
        _viewModel = StateObject(wrappedValue: MealPlannerViewModel(networkClient: networkClient))
    }
    
    var body: some View {
        VStack {
            
            listPicker.disabled(viewModel.isLoading)
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                listView
            }
        }
        .task {
            await viewModel.fetchAllMeals(week: endingPage)
        }
        .onChange(of: endingPage) { oldValue, newValue in
            Task{
                await viewModel.fetchAllMeals(week: endingPage)
            }
        }
//        .sheet(item: $planetPicked) { selectedPlanet in
//            PlanetDetails(planet: $planetPicked)
//        }
//        })
    }
    
    var listView: some View {
        List {
            ForEach(Array(viewModel.mealsSection.enumerated()), id: \.offset) { sectionIndex, section in
                Section("\(section.day) \(section.name)") {
                    ScrollView(.horizontal) {
                        HStack {
                            if section.meals.isEmpty {
                                Text("pipis PIPA")
                            } else {
                                ForEach(Array(section.meals.enumerated()), id: \.offset) { mealIndex, meal in
                                    listRow(meal: meal, section: section)
                                        .onTapGesture {
                                            isPresented = true
                                            selectedIndexes = (sectionIndex,mealIndex)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    @ViewBuilder func listRow(meal: Meal, section: DailyMealListRowModel) -> some View{
        let isSaved = section.savedMealsNames.contains(meal.name)
        if isSaved || section.savedMealsNames.isEmpty {
            VStack{
                AsyncImage(url: .init(string: "https://i.ytimg.com/vi/Hm4r6cPNK5E/sddefault.jpg")!, content: { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipped()
                    case .empty :
                        Color.gray.frame(width: 150, height: 150)
                    default: EmptyView()
                    }})
                Text(meal.name).font(.title)
//                if let temperature = planet.temperature {
//                    Text("Temperature is \(temperature.formatted()) degrees")
//                } else {
//                    Text("-")
//                }
//                Text("Distance is \(planet.distanceLightYear.formatted()) light years")
                
                Button {
                    Task{
                        if isSaved {
                            await viewModel.emptyFavouritePlanets(section: section)
                        } else {
                            await viewModel.saveMealAsFanourite(mealName: meal.name, section: section)

                        }
                    }
                } label: {
                    if section.savedMealsNames.contains(meal.name)
                    {
                        Text("Saved")
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .clipShape(.capsule)
                    } else {
                        Text("Save")
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .clipShape(.capsule)
                    }
                }
                .buttonStyle(.borderless)
            }
            .padding()
            .background(Color.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }

    
    var listPicker: some View {
        HStack {
            Button {
                endingPage -= Self.stepper
            } label: {
                Image(systemName: "chevron.left.circle")
            }
            .disabled(endingPage == Self.stepper)
            
            Text("Page \(endingPage)")
            
            Button {
                endingPage += Self.stepper
            } label: {
                Image(systemName: "chevron.right.circle")
            }
        }
    }

}

#Preview {
    MealPlannerUI(networkClient: MainNetworkClient())
}
