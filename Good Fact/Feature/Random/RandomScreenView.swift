//
//  RandomScreenView.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import SwiftUI

struct RandomScreenView: View {
    @ObservedObject private var viewModel = RandomScreenViewModel(factGeneratorUseCase: FactGeneratorUseCaseImpl(repository: FactGeneratorRepositoryImpl(dataSource: FactGeneratorRemoteDataSource(service: FactGeneratorService.shared))))
    
    @State private var isSharePresented: Bool = false
    
    var body: some View {
        VStack {
            FactCardView(
                fact: viewModel.currentFact,
                isSaved: viewModel.favoriteIdList.contains(where: { $0 == viewModel.currentFact?.id }),
                onFavoriteClicked: { isFavorite in
                    guard let current = viewModel.currentFact else { return }
                    if isFavorite {
                        viewModel.saveToFavorite(fact: current)
                    } else {
                        viewModel.removeToFavorite(id: current.id)
                    }
                }
            )
            
            HStack {
                ActionButtonView(
                    systemName: "arrow.uturn.backward",
                    iconColor: AppColor.blue,
                    isDisabled: viewModel.prevCurrentFact == nil,
                    onClickListener: viewModel.goBackToPrevious
                ).frame(maxWidth: .infinity)
                
                let hasExistingCurrentFact = viewModel.currentFact != nil
                ActionButtonView(
                    systemName: "paperplane",
                    iconColor: AppColor.blue,
                    isDisabled: !hasExistingCurrentFact,
                    onClickListener: { isSharePresented = true }
                ).frame(maxWidth: .infinity)
                
                ActionButtonView(
                    systemName: hasExistingCurrentFact ? "arrow.right" : "arrow.clockwise",
                    iconColor: AppColor.blue,
                    onClickListener:
                        hasExistingCurrentFact ? viewModel.goToNext : viewModel.refresh
                ).frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $isSharePresented) {
            if let fact = viewModel.currentFact {
                let shareText = "\(fact.text) Source: \(fact.source)"
                
                ShareInfoView(activityItems: [shareText])
            }
        }
    }
}

#Preview {
    RandomScreenView()
}
