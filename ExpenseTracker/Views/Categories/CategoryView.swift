//
//  CategoryView.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct CategoryView: View {
    
    var category: Category
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Expense.entity(), sortDescriptors: []) var expenses: FetchedResults<Expense>
    @State var total: Double = 0
    
    init(category: Category) {
        self.category = category
        _expenses = FetchRequest<Expense>(entity: Expense.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: false)], predicate: NSPredicate(format: "category == %@", self.category))
    }
    
    func groupByDate(_ result : FetchedResults<Expense>)-> [[Expense]]{
        return  Dictionary(grouping: result){ (element : Expense)  in
            element.date!.toString(format: "dd/MM/yyyy")
        }.values.map{$0}.reversed()
    }
    
    var body: some View {
        ZStack (alignment: .top) {
            VStack (alignment: .leading, spacing: 20) {
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
                .colorMultiply(Color("lightGrey"))
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(.top, 40)
            .background(Color("lightGrey"))
            .edgesIgnoringSafeArea(.bottom)
            
            VStack (alignment: .leading, spacing: 20) {
                HStack {
                    FAText(iconName: self.category.icon ?? "question", size: 20).frame(width: 25, height: 20)
                    Text(self.category.title ?? "")
                }.font(.largeTitle)
                Text("\(self.expenses.count) entries for this category and a total of \(self.total.format())€").font(.callout)
            }
            .padding()
            .padding(.top, 20)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 170, maxHeight: 170)
            .background(Color.white)
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarItems(trailing: Button(action: {
            self.context.delete(self.category)
            
            do {
                try self.context.save()
            } catch {
                print(error)
            }
            
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Delete category")
                .font(.body)
                .padding([.top, .bottom], 5)
                .padding([.leading, .trailing], 10)
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(10)
        }).padding(.top, 10))
    }
    
    func delete(index: IndexSet) {
        let element = self.expenses[index.first!]
        self.total -= element.amount
        self.context.delete(element)
        
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}
