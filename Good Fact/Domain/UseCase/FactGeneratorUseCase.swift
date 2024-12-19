//
//  FactGeneratorUseCase.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import RxSwift

protocol FactGeneratorUseCase {
    func getRandomFact() -> Single<Fact>
    func getDailyFact() -> Single<Fact>
}

final class FactGeneratorUseCaseImpl: FactGeneratorUseCase {
    private var repository: FactGeneratorRepository
    
    init(repository: FactGeneratorRepository) {
        self.repository = repository
    }
    
    func getRandomFact() -> Single<Fact> {
        return repository.getRandomFact()
    }
    
    func getDailyFact() -> Single<Fact> {
        return repository.getDailyFact()
    }
}
