//
//  ActionButtonView.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import SwiftUI

struct ActionButtonView: View {
    var onClickListener: (() -> Void)? = nil
    var systemName: String
    var isDisabled: Bool
    var iconColor: Color
    
    init(systemName: String, iconColor: Color = AppColor.inverseSecondary, isDisabled: Bool = false, onClickListener: (() -> Void)? = nil) {
        self.onClickListener = onClickListener
        self.isDisabled = isDisabled
        self.systemName = systemName
        self.iconColor = iconColor
    }
    
    var body: some View {
        Button(
            action: {
                onClickListener?()
            }
        ) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundStyle(iconColor)
        }
        .clipShape(.circle)
        .overlay {
            Circle()
                .stroke(iconColor, lineWidth: 3)
        }
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
    }
}
