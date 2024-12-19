//
//  FactGeneratorRepositoryImpl.swift
//  Good Fact
//
//  Created by androiddev on 12/9/24.
//

import RxSwift

final class FactGeneratorRepositoryImpl: FactGeneratorRepository {
    private var dataSource: FactGeneratorRemoteDataSource
    
    public init(dataSource: FactGeneratorRemoteDataSource) {
        self.dataSource = dataSource
    }
    
    func getRandomFact() -> Single<Fact> {
        return Single.create { single in
            self.dataSource.getRandomFact().subscribe(
                onSuccess: { result in
                    single(.success(result.toModel()))
                },
                onFailure: { error in
                    single(.failure(error))
                }
            )
        }
    }
    
    func getDailyFact() -> Single<Fact> {
        return Single.create { single in
            self.dataSource.getDailyFact().subscribe(
                onSuccess: { result in
                    single(.success(result.toModel()))
                },
                onFailure: { error in
                    single(.failure(error))
                }
            )
        }

    }
}
