//
//  ApplicationConfig.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import Foundation

struct ApplicationConfig: Decodable {

    let issuer: String
    let clientID: String
    let redirectUri: String
    let postLogoutRedirectUri: String
    let scope: String

    init() {

        self.issuer = "https://profile.miem.hse.ru/auth/realms/MIEM"
//        self.clientID = "odoo-mobileapp"
        self.clientID = "odoo-mobile-app"
        self.redirectUri = "odoo.miem.ios://auth.hse.ru/odoo.miem.ios/callback"
//        self.postLogoutRedirectUri = ""
        self.postLogoutRedirectUri = "odoo.miem.ios://auth.hse.ru/odoo.miem.ios/logoutcallback"
        self.scope = "openid profile"
//        self.scope = ""

    }

    func getIssuerUri() -> (URL?, Error?) {

        guard let url = URL(string: self.issuer) else {

            let error = ApplicationError(title: "Invalid Configuration Error", description: "The issuer URI could not be parsed")
            return (nil, error)
        }

        return (url, nil)
    }

    func getRedirectUri() -> (URL?, Error?) {
        guard let url = URL(string: self.redirectUri) else {
            let error = ApplicationError(title: "Invalid Configuration Error", description: "The redirect URI could not be parsed")
            return (nil, error)
        }

        return (url, nil)
    }

    func getPostLogoutRedirectUri() -> (URL?, Error?) {

        guard let url = URL(string: self.postLogoutRedirectUri) else {

            let error = ApplicationError(title: "Invalid Configuration Error", description: "The post logout redirect URI could not be parsed")
            return (nil, error)
        }

        return (url, nil)
    }
}
