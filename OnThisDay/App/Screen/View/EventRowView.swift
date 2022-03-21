//
//  EventRowView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 17/03/22.
//

import SwiftUI

struct EventRowView: View {
    
    var photo: String?
    let title: String
    let year: Int
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5.0) {
                Text(title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .padding()
                Text(String(year))
                    .bold()
                    .padding()
            }
            Spacer()
            AsyncImage(url: URL(string: photo ?? ""), scale: 3.0) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center) // Displays the loaded image.
                } else if phase.error != nil {
                    ProgressView()
                } else {
                    Image(systemName: "photo")
                        .frame(width: 50, height: 50, alignment: .center)
                }
            }
            .clipShape(Circle())
        }
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(title: "News title", year: 2022)
    }
}
