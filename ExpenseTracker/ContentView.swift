//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 14/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        TabView {
            Homepage() {
                Expenses()
            }.tabItem({
                Image(systemName: "eurosign.circle")
                Text("Expenses")
            })
            Homepage() {
                Categories()
            }.tabItem({
                Image(systemName: "list.bullet")
                Text("Categories")
            })
        }
    }
}
