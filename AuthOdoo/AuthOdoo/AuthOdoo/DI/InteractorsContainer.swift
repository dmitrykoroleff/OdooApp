//
//  InteractorsContainer.swift
//  AuthOdoo
//
//  Created by Melanie Kofman on 16.11.2022.
//

import Foundation
extension DIContainer {
    struct Interactors {
        let authenticateInteractor: AuthenticateInteractorProtocol
        
        init(authenticateInteractor: AuthenticateInteractorProtocol) {
            self.authenticateInteractor = authenticateInteractor
        }
        
        static var stub: Self {
            .init(authenticateInteractor: StubAuthenticateInteractor())
        }
    }
}

