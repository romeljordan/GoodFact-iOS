//
//  FavoriteScreenView.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import SwiftUI

struct FavoriteScreenView: View {
    @ObservedObject private var viewModel: FavoriteScreenViewModel = FavoriteScreenViewModel()
    private let bgColors = [AppColor.blue, AppColor.green, AppColor.orange, AppColor.brown, AppColor.darkBrown]
    
    var body: some View {
        VStack {
            Text("Saved")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 25, weight: .bold))
                .padding(.leading, 24)
            
            if viewModel.savedList.isEmpty {
                VStack(alignment: .center) {
                    Text("No saved facts yet")
                        .font(.system(size: 18, weight: .light))
                        .italic()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.savedList) { item in
                            let index = viewModel.savedList.firstIndex(where: { $0.id == item.id })
                            let bgColor = index == nil ? AppColor.darkBrown : bgColors[index! % bgColors.count]
                            FavoriteItemView(
                                factText: item.text,
                                sourceText: item.source,
                                bgColor: bgColor,
                                onDeselectListener: {
                                    viewModel.removeSavedItem(id: item.id)
                                }
                            )
                        }
                    }
                    .padding()
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    FavoriteScreenView()
}
