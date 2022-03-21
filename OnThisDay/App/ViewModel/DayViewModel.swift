//
//  DayViewModel.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 15/03/22.
//

import Foundation

class DayViewModel: ObservableObject {
    
    @Published var newsDay: [DayModel] = []
    
    func fetchSpecificDate(day: String) async throws {
        let urlString = "https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/all/\(day)"
        try? await performRequest(with: urlString)
    }
    
    func reload() async {
        newsDay = []
    }
    
    //    func fetchSpeficDate(day: String) {
    //        let urlString = "https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/all/\(day)"
    //        performRequest(with: urlString)
    //    }
    //
    //    func performRequest(with urlString: String) {
    //
    //        let request = URLRequest(url: URL(string: urlString)!)
    //        let session = URLSession(configuration: .default)
    //        let task = session.dataTask(with: request) { data, response, error in
    //
    //            let httpResponse = response as? HTTPURLResponse
    //            print(httpResponse!.statusCode)
    //
    //            guard error == nil,
    //                  let data = data,
    //                  let httpsResponse = response as? HTTPURLResponse,
    //                  httpsResponse.statusCode == 200 else {
    //                print(error)
    //                return
    //            }
    //
    //            if let news = try? JSONDecoder().decode(DayResponse.self, from: data) {
    //                DispatchQueue.main.async {
    //                    for i in 0..<news.selected.count {
    //                        let title = news.selected[i].pages[0].titles.normalized
    //                        let text = news.selected[i].text
    //                        let year = news.selected[i].year
    //                        let new = DayModel(title: title, text: text, year: year)
    //                        self.newsDay.append(new)
    //
    //                    }
    //                }
    //            }
    //
    //        }
    //        task.resume()
    //    }
    
    func performRequest(with urlString: String) async throws {
        
        let request = URLRequest(url: URL(string: urlString)!)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw fatalError() }
        if let news = try? JSONDecoder().decode(DayResponse.self, from: data) {
            DispatchQueue.main.async {
                for i in 0..<news.selected.count {
                    let title = news.selected[i].pages[0].titles.normalized
                    let text = news.selected[i].text
                    let year = news.selected[i].year
                    let photoUrl = news.selected[i].pages[0].thumbnail?.source
                    let originalPhotoUrl = news.selected[i].pages[0].originalImage?.source
                    let link = news.selected[i].pages[0].contentUrls.desktop.page
                    let extract = news.selected[i].pages[0].extract
                    let new = DayModel(title: title, text: text, year: year, photoUrl: photoUrl ?? "", originalPhotoUrl: originalPhotoUrl ?? "", link: link, extract: extract)
                    self.newsDay.append(new)
                }
                self.sortArrayIncreasing()
            }
        }
    }
    
    func sortArrayDecreasing() {
        newsDay.sort {
            $0.year < $1.year
        }
    }
    
    func sortArrayIncreasing() {
        newsDay.sort {
            $0.year > $1.year
        }
    }
    
    func formatDateIntoString(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM/dd"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    func convert(_ string: String) -> String {
        var components = string.components(separatedBy: "/")
        switch components[0] {
        case "01":
            components[0] = "January "
        case "02":
            components[0] = "February "
        case "03":
            components[0] = "March "
        case "04":
            components[0] = "April "
        case "05":
            components[0] = "May "
        case "06":
            components[0] = "June "
        case "77":
            components[0] = "July "
        case "08":
            components[0] = "August "
        case "09":
            components[0] = "September "
        case "10":
            components[0] = "October "
        case "11":
            components[0] = "November "
        case "12":
            components[0] = "December "
        default:
            components[0] = "error "
        }
        switch components[1] {
        case "01":
            components[1] = "1"
        case "02":
            components[1] = "2"
        case "03":
            components[1] = "3"
        case "04":
            components[1] = "4"
        case "05":
            components[1] = "5"
        case "06":
            components[1] = "6"
        case "07":
            components[1] = "7"
        case "08":
            components[1] = "8"
        case "09":
            components[1] = "9"
        default:
            components[1] = components[1]
        }
        let convertedString = components[0] + components[1]
        return convertedString
    }
}
