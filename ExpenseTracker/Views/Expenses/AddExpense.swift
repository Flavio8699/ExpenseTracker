//
//  AddExpense.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct AddExpense: View {
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) var categories: FetchedResults<Category>
    @State private var caption: String = ""
    @State private var category: Int = 0
    @State private var amount: String = ""
    @State private var type: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Description", text: $caption)
                    TextField("Amount", text: $amount).keyboardType(.decimalPad)
                    Picker(selection: $type, label: Text("Type")) {
                        Text("Outgoing").tag(0)
                        Text("Incoming").tag(1)
                    }
                }
                Section {
                    Picker(selection: $category, label: Text("Category")) {
                        ForEach(0..<self.categories.count, id: \.self) { id in
                            HStack {
                                FAText(iconName: self.categories[id].icon!, size: 18)
                                Text(self.categories[id].title!).tag(id)
                            }
                        }
                    }
                }
                Button(action: {
                    let expense = Expense(context: self.context)
                    expense.caption = self.caption
                    expense.category = self.categories[self.category]
                    expense.amount = Double("\(self.type == 0 ? "-" : "")\(self.amount.replacingOccurrences(of: ",", with: "."))") ?? 0
                    expense.rowid = UUID()
                    expense.date = Date()
                    
                    do {
                        try self.context.save()
                    } catch {
                        print(error)
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Create new expense")
                })
            }
            .navigationBarTitle("Create new expense", displayMode: .inline)
        }
    }
}
