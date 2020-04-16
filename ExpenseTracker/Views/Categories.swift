//
//  Categories.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import QGrid
import FASwiftUI

struct Categories: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) var categories: FetchedResults<Category>
    @State private var chartView: Bool = false
    @State private var listView: Bool = true
    
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                VStack (alignment: .leading) {
                    Text("CATEGORIES")
                    Text("\(self.categories.count) total").font(.caption).foregroundColor(.secondary)
                }
                Spacer()
                RoundedButton(icon: "chart-pie", selected: chartView, action: {
                    self.chartView = true
                    self.listView = false
                })
                RoundedButton(icon: "list", selected: listView, action: {
                    self.chartView = false
                    self.listView = true
                })
            }
            if self.listView {
                ZStack (alignment: .bottomTrailing) {
                    QGrid(self.categories, columns: 2, vPadding: 0, hPadding: 0) { category in
                        NavigationLink(destination: CategoryView(category: category)) {
                            CategoryCell(category: category)
                                .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 2)
                        }
                    }
                    NavigationLink(destination: AddCategory().environment(\.managedObjectContext, self.context)) {
                        ZStack {
                            Circle().fill(Color("lightOrange")).frame(width: 60, height: 60)
                            FAText(iconName: "plus", size: 30).foregroundColor(Color.white)
                        }
                    }.padding(.bottom, 50)
                }
            }
            if self.chartView {
                Text("charts")
            }
            Spacer()
        }
        .padding()
    }
}
