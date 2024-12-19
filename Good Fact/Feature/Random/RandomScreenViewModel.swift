//
//  RandomScreenViewModel.swift
//  Good Fact
//
//  Created by androiddev on 12/13/24.
//

import Foundation
import RxSwift
import Combine

enum ViewState {
    case initial
    case loading
    case ready
    case error
}

final class RandomScreenViewModel: ObservableObject {
    private var factGeneratorUseCase: FactGeneratorUseCase
    private let disposedBag = DisposeBag()
//    let defaultFact = Fact(
//        id: "",
//        source: "savit.in",
//        text: "\"I Am\" is the shortest complete sentence in the English language"
//    )
    
    @Published private(set) var viewState: ViewState = .initial
    @Published private(set) var currentFact: Fact? = nil
    @Published private(set) var prevCurrentFact: Fact? = nil
    @Published private(set) var favoriteIdList: [String] = []
    private var nextFact: Fact? = nil
    
    public init(factGeneratorUseCase: FactGeneratorUseCase) {
        self.factGeneratorUseCase = factGeneratorUseCase
        
        favoriteIdList = FavoriteFactStorageManager.shared.fetch()
            .map({ $0.id! })
        
        loadFact()
        preloadNextFact()
    }
    
    private func loadFact() {
        viewState = .loading
        factGeneratorUseCase.getRandomFact()
            .subscribe(
                with: self,
                onSuccess: { owner, result in
                    owner.currentFact = result
                    owner.viewState = .ready
                },
                onFailure: { owner, _ in
                    owner.currentFact = storedFacts.randomElement()
                    owner.viewState = .ready
                }
            )
            .disposed(by: disposedBag)
    }
    
    private func preloadNextFact() {
        factGeneratorUseCase.getRandomFact()
            .subscribe(
                with: self,
                onSuccess: { owner, result in
                    if result.id == owner.currentFact?.id {
                        owner.preloadNextFact()
                    } else {
                        owner.nextFact = result
                    }
                },
                onFailure: { owner, _ in
                    guard let result = storedFacts.randomElement() else { return }
                    if result.id == owner.currentFact?.id {
                        owner.preloadNextFact()
                    } else {
                        owner.nextFact = result
                    }
                }
            )
            .disposed(by: disposedBag)
    }
    
    func goBackToPrevious() {
        nextFact = currentFact
        currentFact = prevCurrentFact
        prevCurrentFact = nil
    }
    
    func refresh() {
        loadFact()
        preloadNextFact()
    }
    
    func goToNext() {
        prevCurrentFact = currentFact
        currentFact = nextFact
        preloadNextFact()
    }
    
    func saveToFavorite(fact: Fact) {
        FavoriteFactStorageManager.shared.addFavorite(id: fact.id, content: fact.text, source: fact.source)
        favoriteIdList.append(fact.id)
    }
    
    func removeToFavorite(id: String) {
        FavoriteFactStorageManager.shared.delete(id: id)
        favoriteIdList.removeAll(where: { $0 == id })
    }
}
