//
//  AddCategory.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct AddCategory: View {
    
    private var colors: [String] = ["Green", "Blue", "Yellow", "lightOrange"]
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var icon: String?
    @State private var color: Int = 0
    @State private var showingPicker: Bool = false
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                HStack {
                    Button(action: {
                        self.showingPicker = true
                    }) {
                        Text("Choose icon").foregroundColor(.primary)
                    }
                    Spacer()
                    FAText(iconName: self.icon ?? "question", size: 30)
                }
                Picker(selection: $color, label: Text("Color")) {
                    ForEach(0..<self.colors.count, id: \.self) {
                        Text(self.colors[$0]).tag($0)
                    }
                }
            }
            Button(action: {
                let category = Category(context: self.context)
                category.title = self.title
                category.icon = self.icon ?? "question"
                category.color = self.colors[self.color]
                category.rowid = UUID()
                
                do {
                    try self.context.save()
                } catch {
                    print("error")
                }
                
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create new category")
            })
        }
        .sheet(isPresented: $showingPicker) {
            FAPicker(showing: self.$showingPicker, selected: self.$icon)
        }
        .navigationBarTitle("Create new category", displayMode: .inline)
    }
}
