//
//  EventDetailView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 17/03/22.
//

import SwiftUI

struct EventDetailView: View {
    
    let title: String
    let text: String
    let photo: String?
    let link: String
    let extract: String
    let year: Int
    
    var body: some View {
        VStack(spacing: 10.0) {
            HStack{
                Text(text)
                    .font(.title2)
                    .bold()
                    .padding()
                Spacer()
                
            }
            Text(extract)
                .font(.body)
                .padding()
            Spacer()
            Text(String(year))
                .font(.system(size: 60))
                .bold()
                .foregroundColor(.red)
                .opacity(0.7)
                .shadow(color: .red, radius: 0, x: 0, y: 4)
            Spacer()
            
            LinkView(link: link)
        }
        .background(
            AsyncImage(url: URL(string: photo ?? ""), scale: 3.0) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .cornerRadius(25)
                        .scaledToFill()
                        .opacity(0.2)
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                }
            }
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailView(title: "News Title", text: "News text", photo: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Putin_with_Vladimir_Konstantinov%2C_Sergey_Aksyonov_and_Alexey_Chaly_4.jpeg/320px-Putin_with_Vladimir_Konstantinov%2C_Sergey_Aksyonov_and_Alexey_Chaly_4.jpeg", link: "ciao", extract: "In February and March 2014, Russia invaded and subsequently annexed the Crimean Peninsula from Ukraine. This event took place in the aftermath of the Revolution of Dignity and is part of the wider Russo-Ukrainian War.", year: 2014)
    }
}
