//
//  DatePickerView.swift
//  OnThisDay
//
//  Created by Simone Ottavianelli on 19/03/22.
//

import SwiftUI

struct DatePickerView: View {
    
    @Binding var date: Date
    
    var body: some View {
        DatePicker("Select a date", selection: $date, displayedComponents: .date)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()))
    }
}
