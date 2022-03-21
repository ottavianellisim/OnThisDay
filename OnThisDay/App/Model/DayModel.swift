//
//  DayModel.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 15/03/22.
//

import Foundation

struct DayModel: Identifiable {
    let id = UUID()
    let title: String
    let text: String
    let year: Int
    let photoUrl: String
    let originalPhotoUrl: String
    let link: String
    let extract: String
}
