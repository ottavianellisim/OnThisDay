//
//  LoadingView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 19/03/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Caricamento notizie in corso...")
                .bold()
                .font(.title2)
                .padding()
            ProgressView()
                .frame(width: 80, height: 80, alignment: .center)
                .padding()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
