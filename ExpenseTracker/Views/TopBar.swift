//
//  TopBar.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct TopBar: View {
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                VStack (alignment: .leading) {
                    Text("My Expenses").font(.title)
                    Text("Summary").font(.caption).foregroundColor(.secondary)
                }
                Spacer()
            }
            HStack (spacing: 15) {
                FAText(iconName: "calendar-alt", size: 18)
                VStack (alignment: .leading) {
                    Text(Date().toString(format: "dd MMMM, yyyy")).font(.footnote)
                    Text("placeholder").font(.caption).foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .padding(.top, 20)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 170, maxHeight: 170)
        .background(Color.white)
        .edgesIgnoringSafeArea(.top)
    }
}
