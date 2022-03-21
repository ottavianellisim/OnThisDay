//
//  LinkView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 17/03/22.
//

import SwiftUI

struct LinkView: View {
    
    var link: String
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            HStack {
                Text("Learn more on Wikipedia")
                Image(systemName: "book")
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .frame(width: 300, height: 50)
                .foregroundColor(.white)
                .opacity(0.4)
                .shadow(color: .black, radius: 15, x: 0, y: 25)
        )
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(link: "ciao")
            .previewLayout(.sizeThatFits)
    }
}
