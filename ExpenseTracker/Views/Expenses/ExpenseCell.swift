//
//  ExpenseCell.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct ExpenseCell: View {
    
    var expense: Expense
    @Binding var total: Double
    
    var body: some View {
        HStack {
            FAText(iconName: self.expense.category?.icon ?? "question", size: 22).foregroundColor((self.expense.category?.color != nil ? Color(self.expense.category!.color!) : Color.black))
            VStack (alignment: .leading) {
                Text(self.expense.caption ?? "").font(.headline)
                Text("Category: " + (self.expense.category?.title ?? "No category")).font(.subheadline)
            }
            Spacer()
            Text("\(self.expense.amount >= 0 ? "+" : "")\(self.expense.amount.format()) €").foregroundColor(self.expense.amount >= 0 ? Color.green : Color.red)
        }.onAppear(perform: {
            self.total += self.expense.amount
        })
    }
}
