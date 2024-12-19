//
//  FavoriteItemView.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import SwiftUI

struct FavoriteItemView: View {
    private var factText: String
    private var sourceText: String
    private var bgColor: Color
    private var onDeselectListener: (() -> Void)? = nil
    
    init(factText: String, sourceText: String, bgColor: Color = AppColor.blue, onDeselectListener: (() -> Void)? = nil) {
        self.factText = factText
        self.sourceText = sourceText
        self.bgColor = bgColor
        self.onDeselectListener = onDeselectListener
    }
    
    var body: some View {
        VStack(
            alignment: .trailing
        ) {
            Image(systemName: "heart.fill")
                .foregroundStyle(.red)
                .onTapGesture {
                    onDeselectListener?()
                }
            
            VStack(spacing: 8) {
                Text(factText)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                
                Text(sourceText)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 15, weight: .thin))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.white)
                    .italic()
            }
            .padding(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
        }
        .padding()
        .background(bgColor)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    FavoriteItemView(factText: "Lorem ipsum", sourceText: "source")
}
