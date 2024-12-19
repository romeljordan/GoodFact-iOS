//
//  FactGeneratorService.swift
//  Good Fact
//
//  Created by androiddev on 12/13/24.
//

import Alamofire
import RxSwift

final class FactGeneratorService {
    static let shared = FactGeneratorService()

    private init() { }
    
    func getRandomFact() -> Single<ResultDto> {
        return Single.create { single in
            let endPoint = "api/v2/facts/random"
            let url = "\(AppConfig.API_BASE_URL)"
            
            let request = AF.request("\(url)\(endPoint)", method: .get)
                .validate()
                .responseDecodable(of: ResultDto.self) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }
    
    func getDailyFact() -> Single<ResultDto> {
        return Single.create { single in
            let endPoint = "api/v2/facts/today"
            let url = "\(AppConfig.API_BASE_URL)"
            
            let request = AF.request("\(url)\(endPoint)", method: .get)
                .validate()
                .responseDecodable(of: ResultDto.self) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create { request.cancel() }
        }
    }
}
