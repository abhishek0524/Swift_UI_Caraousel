//
//  ContentView.swift
//  SwiftUI_Image_Carousel
//
//  Created by apple on 14/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var images = ["1", "2", "3", "4", "5"]
    @State private var arrTblVW = [["Apple", "Good Fruit in Red Color", "a"],
                                   ["Banana", "Good Fruit in yellow Color", "b"],
                                   ["Rose", "Good flower in Red Color", "c"],
                                   ["Cherry", "Good Fruit in pink Color", "d"],
                                   ["Papaya", "Good Fruit in yellowish Color", "e"],
                                   ["Orange", "Good Fruit in Orange Color", "f"],
                                   ["Black Berry", "Good Fruit in Black Color", "a"],
                                   ["Strawberry", "Good Fruit in pink Color", "b"],
                                   ["Mango", "Good Fruit in yellow Color", "c"],
                                   ["Tomato", "Good Fruit in Red Color", "d"]]
    @State private var searchText = ""
    @State private var isFilterActive = false
    @State private var arrFilter: [[String]] = []
    @State private var currentPage = 0
    @State private var showBottomSheet = false

    var body: some View {
     NavigationView {
        ScrollView {
            VStack {
                // Carousel
                CarouslView(currentPage: $currentPage, images: $images)
                
                // Search Bar
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onChange(of: searchText){ newValue in
                        if newValue.isEmpty {
                            isFilterActive = false
                        } else {
                            isFilterActive = true
                        }
                        
                        filterArray()
                    }
                
                // Table/List View
                TblListVW(filteredArray: isFilterActive ? $arrFilter : $arrTblVW)
            
            }
        }
            .overlay(
                // Floating Action Button
                Button(action: {
                    showBottomSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(color: .gray, radius: 5, x: 0, y: 3)
                }
                .padding(), alignment: .bottomTrailing
            )
            .sheet(isPresented: $showBottomSheet) {
                BottomSheetView(list: arrTblVW.map { $0[0].lowercased() })
            }
            .navigationTitle("")
            .frame(maxHeight: UIScreen.main.bounds.height * 1.25)
        }
    }

//    var filteredArray: [[String]] {
//        isFilterActive ? arrFilter : arrTblVW
//    }
    
    func filterArray() {
        if searchText.isEmpty {
            isFilterActive = false
            arrFilter = arrTblVW
        } else {
            isFilterActive = true
            arrFilter = arrTblVW.filter { $0[0].localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct BottomSheetView: View {
    let list: [String]

    var body: some View {
        VStack(alignment: .leading) {
            let statistics = calculateStatistics(for: list)

            Text("List (\(statistics.totalItems) items)")
                .font(.headline)
                .padding()

            ForEach(statistics.top3, id: \ .0) { char, count in
                Text("\(char) = \(count)")
                    .font(.body)
                    .padding(.horizontal)
            }
            Spacer()
        }
        .presentationDetents([.medium, .large])
    }

    func calculateStatistics(for list: [String]) -> (totalItems: Int, top3: [(Character, Int)]) {
        let totalItems = list.count
        var charCounts = [Character: Int]()

        list.forEach { word in
            word.forEach { char in
                charCounts[char, default: 0] += 1
            }
        }

        let top3 = charCounts.sorted { $0.value > $1.value }.prefix(3)
        return (totalItems, Array(top3))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
