//
//  FactGeneratorRepository.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import RxSwift

protocol FactGeneratorRepository {
    func getRandomFact() -> Single<Fact>
    func getDailyFact() -> Single<Fact>
}
