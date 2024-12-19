//
//  FactCard.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import SwiftUI

struct FactCardView: View {
    private var fact: Fact?
    private var isSaved: Bool
    private var onActionClicked: ((_ value: Bool) -> Void)? = nil
    
    init(fact: Fact?, isSaved: Bool = false, onFavoriteClicked: ((_ value: Bool) -> Void)? = nil) {
        self.fact = fact
        self.isSaved = isSaved
        self.onActionClicked = onFavoriteClicked
    }
    
    var body: some View {
        return VStack(
            alignment: .leading,
            spacing: 12
        ) {
            if let info = fact {
                HStack{
                    Spacer()
                    Image(systemName: isSaved == true ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(
                            isSaved == true ? Color.red : Color.white
                        )
                }
                .padding(8)
                .onTapGesture {
                    onActionClicked?(!isSaved)
                }
                
                Spacer()
                
                Text("Random Fact")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.white)
                
                Text(info.text.replacing("`", with: "'"))
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(Color.white)
                
                Text("source: \(info.source)")
                    .font(.system(size: 14, weight: .thin))
                    .foregroundStyle(Color.white)
                    .italic()
                
                Spacer()
            } else {
                LoadingAnimationView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(16)
        .background(Color(hex: 0xff292d3f))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
//    FactCardView(fact: Fact(id: "", source: "source", text: "Lorem ipsum text"))
    FactCardView(fact: nil)
}
