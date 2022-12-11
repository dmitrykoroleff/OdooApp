//
//  AppAuthHandler.swift
//  odooapp
//
//  Created by Данила on 23.10.2022.
//

import AppAuth
import SwiftCoroutine

class AppAuthHandler {

    private let config: ApplicationConfig
    private var userAgentSession: OIDExternalUserAgentSession?

    init(config: ApplicationConfig) {
        self.config = config
        self.userAgentSession = nil
    }

    /*
     * Get OpenID Connect endpoints
     */
    func fetchMetadata() throws -> CoFuture<OIDServiceConfiguration> {

        let promise = CoPromise<OIDServiceConfiguration>()

        let (issuerUrl, parseError) = self.config.getIssuerUri()
        if issuerUrl == nil {
            promise.fail(parseError!)
            return promise
        }

        OIDAuthorizationService.discoverConfiguration(forIssuer: issuerUrl!) { metadata, err in
            if metadata != nil {
                promise.success(metadata!)
            } else {
                let error = self.createAuthorizationError(title: "Metadata Download Error", err: err)
                promise.fail(error)
            }
        }
        return promise
    }

    /*
     * Trigger a redirect with standard parameters
     * acr_values can be sent as an extra parameter, to control authentication methods
     */
    func performAuthorizationRedirect(
        metadata: OIDServiceConfiguration,
        clientID: String,
        clienSecret: String = "40578971-0fcc-4c79-9224-0a6cc1aa8c67",
        viewController: UIViewController) -> CoFuture<OIDAuthorizationResponse?> {

            let promise = CoPromise<OIDAuthorizationResponse?>()

            let (redirectUri, parseError) = self.config.getRedirectUri()
            if redirectUri == nil {
                promise.fail(parseError!)
                return promise
            }

            // Use acr_values to select a particular authentication method at runtime
            let extraParams = [String: String]()

            let scopesArray = self.config.scope.components(separatedBy: " ")
            let request = OIDAuthorizationRequest(
                configuration: metadata,
                clientId: clientID,
                clientSecret: clienSecret,
                scopes: scopesArray,
                redirectURL: redirectUri!,
                responseType: OIDResponseTypeCode,
                additionalParameters: extraParams)

            let userAgent = OIDExternalUserAgentIOS(presenting: viewController)
            self.userAgentSession = OIDAuthorizationService.present(request, externalUserAgent: userAgent!) { response, err in

                if response != nil {
                    let code = response!.authorizationCode == nil ? "" : response!.authorizationCode!
                    let state = response!.state == nil ? "" : response!.state!
                    print(code, state)
                    promise.success(response!)
                } else {
                    if err != nil && self.isUserCancellationErrorCode(err: err!) {
                        promise.success(nil)
                    } else {

                        let error = self.createAuthorizationError(title: "Authorization Request Error", err: err)
                        promise.fail(error)
                    }
                }
                self.userAgentSession = nil
            }
            return promise
        }

    /*
     * Handle the authorization response, including the user closing the Chrome Custom Tab
     */
    func redeemCodeForTokens(
        clientID: String,
        authResponse: OIDAuthorizationResponse) -> CoFuture<OIDTokenResponse> {

            let promise = CoPromise<OIDTokenResponse>()

            let extraParams = [String: String]()
            let request = authResponse.tokenExchangeRequest(withAdditionalParameters: extraParams)

            OIDAuthorizationService.perform(
                request!,
                originalAuthorizationResponse: authResponse) { tokenResponse, err in

                    if tokenResponse != nil {
                        let accessToken = tokenResponse!.accessToken == nil ? "" : tokenResponse!.accessToken!
                        let refreshToken = tokenResponse!.refreshToken == nil ? "" : tokenResponse!.refreshToken!
                        let idToken = tokenResponse!.idToken == nil ? "" : tokenResponse!.idToken!
                        Logger.debug(data: "AT: \(accessToken), RT: \(refreshToken), IDT: \(idToken)" )

                        promise.success(tokenResponse!)
                    } else {

                        let error = self.createAuthorizationError(title: "Authorization Response Error", err: err)
                        promise.fail(error)
                    }
                }
            return promise
        }

    /*
     * Try to refresh an access token and return null when the refresh token expires
     */
    func refreshAccessToken(
        metadata: OIDServiceConfiguration,
        clientID: String,
        clienSecret: String = "40578971-0fcc-4c79-9224-0a6cc1aa8c67",
        refreshToken: String) -> CoFuture<OIDTokenResponse?> {

            let promise = CoPromise<OIDTokenResponse?>()

            let request = OIDTokenRequest(
                configuration: metadata,
                grantType: OIDGrantTypeRefreshToken,
                authorizationCode: nil,
                redirectURL: nil,
                clientID: clientID,
                clientSecret: clienSecret,
                scope: nil,
                refreshToken: refreshToken,
                codeVerifier: nil,
                additionalParameters: nil)

            OIDAuthorizationService.perform(request) { tokenResponse, err in

                if tokenResponse != nil {
                    let accessToken = tokenResponse!.accessToken == nil ? "" : tokenResponse!.accessToken!
                    let refreshToken = tokenResponse!.refreshToken == nil ? "" : tokenResponse!.refreshToken!
                    let idToken = tokenResponse!.idToken == nil ? "" : tokenResponse!.idToken!
                    print(accessToken, refreshToken, idToken)
                    promise.success(tokenResponse!)

                } else {

                    if err != nil && self.isRefreshTokenExpiredErrorCode(err: err!) {
                        promise.success(nil)

                    } else {

                        let error = self.createAuthorizationError(title: "Refresh Token Error", err: err)
                        promise.fail(error)
                    }
                }
            }

            return promise
        }

    /*
     * Do an OpenID Connect end session redirect and remove the SSO cookie
     */
    func performEndSessionRedirect(metadata: OIDServiceConfiguration,
                                   idToken: String,
                                   viewController: UIViewController) -> CoFuture<Void> {

        let promise = CoPromise<Void>()
        let extraParams = [String: String]()

        let (postLogoutRedirectUri, parseError) = self.config.getPostLogoutRedirectUri()
        if postLogoutRedirectUri == nil {
            promise.fail(parseError!)
            return promise
        }

        let request = OIDEndSessionRequest(
            configuration: metadata,
            idTokenHint: idToken,
            postLogoutRedirectURL: postLogoutRedirectUri!,
            additionalParameters: extraParams)

        let userAgent = OIDExternalUserAgentIOS(presenting: viewController)
        self.userAgentSession = OIDAuthorizationService.present(request, externalUserAgent: userAgent!) { _, err in

            if err != nil {

                if self.isUserCancellationErrorCode(err: err!) {
                    promise.success(Void())
                } else {

                    let error = self.createAuthorizationError(title: "End Session Error", err: err)
                    promise.fail(error)
                }

            } else {

                promise.success(Void())
            }
            self.userAgentSession = nil
        }
        return promise
    }

    /*
     * We can check for specific error codes to handle the user cancelling the ASWebAuthenticationSession window
     */
    private func isUserCancellationErrorCode(err: Error) -> Bool {

        let error = err as NSError
        return error.domain == OIDGeneralErrorDomain && error.code == OIDErrorCode.userCanceledAuthorizationFlow.rawValue
    }

    /*
     * We can check for a specific error code when the refresh token expires and the user needs to re-authenticate
     */
    private func isRefreshTokenExpiredErrorCode(err: Error) -> Bool {

        let error = err as NSError
        return error.domain == OIDOAuthTokenErrorDomain && error.code == OIDErrorCodeOAuth.invalidGrant.rawValue
    }

    /*
     * Process standard OAuth error / error_description fields and also AppAuth error identifiers
     */
    private func createAuthorizationError(title: String, err: Error?) -> ApplicationError {

        var parts = [String]()
        if err == nil {
            parts.append("Unknown Error")
        } else {

            let nsError = err! as NSError

            if nsError.domain.contains("auth.hse.ru") {
                parts.append("(\(nsError.domain) / \(String(nsError.code)))")
            }

            if !err!.localizedDescription.isEmpty {
                parts.append(err!.localizedDescription)
            }
        }

        let fullDescription = parts.joined(separator: " : ")
        let error = ApplicationError(title: title, description: fullDescription)
        return error
    }
}
