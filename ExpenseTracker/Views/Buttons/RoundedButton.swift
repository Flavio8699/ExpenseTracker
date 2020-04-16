//
//  RoundedButton.swift
//  ExpenseTracker
//
//  Created by Flavio Matias on 15/04/2020.
//  Copyright © 2020 Flavio Matias. All rights reserved.
//

import SwiftUI
import FASwiftUI

struct RoundedButton: View {
    
    private let icon: String
    private let selected: Bool
    private let size: CGFloat
    private let action : () -> Void
    
    init(icon: String, selected: Bool, size: CGFloat = 18, action: @escaping () -> Void) {
        self.icon = icon
        self.selected = selected
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle().fill(Color("lightOrange").opacity(self.selected ? 1 : 0)).frame(width: self.size*2, height: self.size*2)
                FAText(iconName: self.icon, size: self.size).foregroundColor(self.selected ? Color.white : Color.gray)
            }
        }
    }
}
