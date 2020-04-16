//
//  CategoryCell.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct CategoryCell: View {
    
    var category: Category
    
    var body: some View {
        HStack (spacing: 15) {
            FAText(iconName: self.category.icon!, size: 18).foregroundColor(Color(self.category.color ?? "lightOrange")).frame(width: 22, height: 18)
            Text(self.category.title!).bold().foregroundColor(.primary)
            Spacer()
        }
        .padding([.top, .bottom], 7)
        .padding([.leading, .trailing], 18)
        .frame(minWidth: 0, maxWidth: 200, minHeight: 0, maxHeight: 40)
        .background(Color.white)
        .cornerRadius(9)
    }
}
