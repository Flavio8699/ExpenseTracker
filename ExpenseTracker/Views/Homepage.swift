//
//  Homepage.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 14/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI

struct Homepage<Content: View>: View {
    
    let content: Content
    @Environment(\.managedObjectContext) var context
    @State private var addExpenseSheet: Bool = false
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                content
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .padding(.top, 40)
                .background(Color("lightGrey"))
                .edgesIgnoringSafeArea(.bottom)
                TopBar()
            }
            .navigationBarTitle("")
            .navigationBarHidden(false)
            .navigationBarItems(trailing: RoundedButton(icon: "plus", selected: true, action: {
                self.addExpenseSheet.toggle()
            }))
            .sheet(isPresented: $addExpenseSheet) {
                AddExpense().environment(\.managedObjectContext, self.context)
            }
        }
    }
}
