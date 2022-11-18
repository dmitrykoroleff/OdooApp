//
//  Auth.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 17.11.2022.
//

import Foundation
import Combine
public class AuthMain {
    var webRepository: AuthenticateWebRepositoryProtocol
    let session = configuredURLSession()
    
    public init() {
        let webRepositories = AuthMain.configuredWebRepositories(session: session)
        self.webRepository = webRepositories.authenticateWebRepository
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 40
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let authenticateWebRepository = AuthenticateWebRepository(
            session: session)
        return .init(authenticateWebRepository: authenticateWebRepository)
    }

    
    public func authenticate(login: Login) {
        print("authenticate in auth main")
        let cancelBag = CancelBag()
//        userResult.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        var cookie: String = ""
//        weak var weakAppState = appState
        webRepository
            .loadServerVersion(login: login)
            .flatMap{ _ -> AnyPublisher<DbResult, Error> in
                return self.webRepository.listDatabase(login: login)
            }
            .flatMap{ dbResult -> AnyPublisher<UserResult, Error> in
                let login: Login = .init(serverUrl: login.serverUrl,
                                         database: dbResult.result.first ?? "",
                                         username: login.username,
                                         password: login.password)
                return self.webRepository.authenticate(login: login) {
                    print("result \($0)")
                    cookie = $0
                }
            }
            .sinkToLoadable {
                dump($0)
//                userResult.wrappedValue = $0
                if var user = $0.value?.result {
                    if user.uid > 0 {
                        user.sessionId = cookie
                    }

//                    weakAppState?[\.userData.user] = user
//                } else {
//                    weakAppState?[\.userData.user] = .init()
//                }
            }
        // TODO: 保存到数据库
//            .store(in: cancelBag)
    }
    }
}
