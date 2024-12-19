//
//  DailyScreenView.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import SwiftUI

struct DailyScreenView: View {
    
    @ObservedObject private var viewModel = DailyScreenViewModel(factGeneratorUseCase: FactGeneratorUseCaseImpl(repository: FactGeneratorRepositoryImpl(dataSource: FactGeneratorRemoteDataSource(service: FactGeneratorService.shared))))
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("Daily Fact")
                .font(.system(size: 25, weight: .bold))
                .padding(.leading, 8)
            FactCardView(
                fact: viewModel.dailyFact,
                isSaved: viewModel.isSaved,
                onFavoriteClicked: { value in
                    if value {
                        viewModel.saveToFavorite()
                    } else {
                        viewModel.removeToFavorite()
                    }
                }
            )
        }
        .padding()
    }
}

#Preview {
    DailyScreenView()
}
