//
//  FactGeneratorRemoteDataSource.swift
//  Good Fact
//
//  Created by androiddev on 12/13/24.
//

import RxSwift

final class FactGeneratorRemoteDataSource {
    private var service: FactGeneratorService
    
    public init(service: FactGeneratorService) {
        self.service = service
    }
    
    func getRandomFact() -> Single<ResultDto> {
        return service.getRandomFact()
    }
    
    func getDailyFact() -> Single<ResultDto> {
        return service.getDailyFact()
    }
}
