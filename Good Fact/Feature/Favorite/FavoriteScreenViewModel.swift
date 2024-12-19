//
//  FavoriteScreenViewModel.swift
//  Good Fact
//
//  Created by androiddev on 12/16/24.
//

import Foundation
import Combine

final class FavoriteScreenViewModel: ObservableObject {
    @Published private(set) var savedList: [Fact] = []
    
    private var cancellable: AnyCancellable?
    
    init(favoritePublisher: AnyPublisher<[Favorite], Never> = FavoriteFactStorageManager.shared.favorites.eraseToAnyPublisher()) {
        cancellable = favoritePublisher.sink { [unowned self] items in
            self.savedList = items
                .filter({ $0.id != nil && $0.content != nil && $0.source != nil })
                .map {
                    Fact(id: $0.id!, source: $0.source!, text: $0.content!)
                }
        }
    }
    
    func removeSavedItem(id: String) {
        FavoriteFactStorageManager.shared.delete(id: id)
    }
}
