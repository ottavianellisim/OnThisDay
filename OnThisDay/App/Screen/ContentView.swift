//
//  ContentView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 15/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var vm = DayViewModel()
    @State private var IncresingOrder: Bool = false
    @State private var yesterdayDate: Bool = false
    @State private var tomorrowDate: Bool = false
    @State private var dataString: [String] = []
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            List {
                DatePickerView(date: $date)
                    .padding()
                ForEach(vm.newsDay) { news in
                    NavigationLink {
                        EventDetailView(title: news.title, text: news.text, photo: news.photoUrl, link: news.link, extract: news.extract, year: news.year)
                            .navigationTitle(news.title)
                            .navigationBarTitleDisplayMode(.inline)
                        
                    } label: {
                        EventRowView(photo: news.originalPhotoUrl, title: news.title, year: news.year)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .toolbar {
                Button {
                    IncresingOrder.toggle()
                    if !IncresingOrder {
                        vm.sortArrayIncreasing()
                    }
                    else {
                        vm.sortArrayDecreasing()
                    }
                } label: {
                    if !IncresingOrder {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                        
                    } else {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                }
                .foregroundColor(.black)
            }
            .navigationTitle(vm.convert(vm.formatDateIntoString(date)))
        }
        .onAppear {
            Task {
                try await vm.fetchSpecificDate(day: vm.formatDateIntoString(Date()))
            }
        }
        .onChange(of: date) { newValue in
            Task {
                await vm.reload()
                try await vm.fetchSpecificDate(day: vm.formatDateIntoString(date))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
