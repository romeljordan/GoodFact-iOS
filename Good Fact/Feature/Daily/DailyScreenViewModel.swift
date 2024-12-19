//
//  DailyScreenViewModel.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import Foundation
import RxSwift

final class DailyScreenViewModel: ObservableObject {
    private var factGeneratorUseCase: FactGeneratorUseCase
    private let disposedBag = DisposeBag()
    
    @Published private(set) var dailyFact: Fact? = nil
    @Published private(set) var isSaved: Bool = false
    
    public init(factGeneratorUseCase: FactGeneratorUseCase) {
        self.factGeneratorUseCase = factGeneratorUseCase
        
        loadFact()
    }
    
    private func loadFact() {
        factGeneratorUseCase.getDailyFact()
            .subscribe(with: self) { owner, result in
                owner.dailyFact = result
            }
            .disposed(by: disposedBag)
    }
    
    private func checkIfIsSaved() {
        guard let currentId = dailyFact?.id else { return }
        
        let resultCount = FavoriteFactStorageManager.shared.fetch()
            .filter({ $0.id == currentId })
            .count
    
        isSaved = (resultCount > 0)
    }
    
    func saveToFavorite() {
        guard let current = dailyFact else { return }
        FavoriteFactStorageManager.shared.addFavorite(id: current.id, content: current.text, source: current.source)
        isSaved = true
    }
    
    func removeToFavorite() {
        guard let current = dailyFact else { return }
        FavoriteFactStorageManager.shared.delete(id: current.id)
        isSaved = false
    }
}
