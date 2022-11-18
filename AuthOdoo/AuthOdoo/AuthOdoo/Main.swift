//
//  Main.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 16.11.2022.
//

import Foundation
import SwiftUI
import Combine
 struct Auth {
     let container: DIContainer

     func auth(login: Login) {
        let injected = container
        @State var userResult: Loadable<UserResult> = .notRequested
        injected.interactors
            .authenticateInteractor
            .authenticate(login: login, userResult: $userResult)
    }

     static func bootstrap() -> Auth {
        let appState = Store<AppState>(AppState())
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let interactors = configuredInteractors(appState: appState,
                                                webRepositories: webRepositories)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return Auth(container: diContainer)
    }


     static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 40
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }

     static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let authenticateWebRepository = AuthenticateWebRepository(
            session: session)
        return .init(authenticateWebRepository: authenticateWebRepository)
    }

     static func configuredInteractors(appState: Store<AppState>,
                                              webRepositories: DIContainer.WebRepositories
    ) -> DIContainer.Interactors {

        let authenticateInteractor = AuthenticateInteractor(
            webRepository: webRepositories.authenticateWebRepository,
            appState: appState)

        return .init(authenticateInteractor: authenticateInteractor)
    }
}

extension DIContainer {
    struct WebRepositories {
        let authenticateWebRepository: AuthenticateWebRepositoryProtocol
    }
}
