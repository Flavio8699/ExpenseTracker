//
//  Expenses.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI

struct Expenses: View {
    
    @FetchRequest(entity: Expense.entity(), sortDescriptors: [
        NSSortDescriptor(key: "date", ascending: false)
    ]) var expenses: FetchedResults<Expense>
    @Environment(\.managedObjectContext) var context
    @State var total: Double = 0
    
    func groupByDate(_ result : FetchedResults<Expense>)-> [[Expense]]{
        return  Dictionary(grouping: result){ (element : Expense)  in
            element.date!.toString(format: "dd/MM/yyyy")
        }.values.map{$0}.reversed()
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text("Total: \(self.total.format())€").bold().padding()
            List {
                ForEach(groupByDate(self.expenses), id: \.self) { (section: [Expense]) in
                    Section(header: Text(section[0].date!.toString(format: "dd/MM/yyyy"))) {
                        ForEach(section, id: \.self) { expense in
                            ExpenseCell(expense: expense, total: self.$total)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
                .edgesIgnoringSafeArea(.horizontal)
            .colorMultiply(Color("lightGrey"))
        }
    }
    
    func delete(index: IndexSet) {
        self.context.delete(self.expenses[index.first!])
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}
