//
//  Request+Authentication.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 3/23/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

private let GrantTypeKey = "grant_type"
private let ScopeKey = "scope"
private let CodeKey = "code"
private let RedirectURIKey = "redirect_uri"
private let UsernameKey = "username"
private let PasswordKey = "password"
private let DisplayNameKey = "display_name"
private let EmailKey = "email"
private let TokenKey = "token"
private let PinCodeKey = "user_code"
private let DeviceCodeKey = "device_code"
private let AccessTokenKey = "access_token"

private let GrantTypeClientCredentials = "client_credentials"
private let GrantTypeAuthorizationCode = "authorization_code"
private let GrantTypePassword = "password"
private let GrantTypeFacebook = "facebook"
private let GrantTypePinCode = "device_grant"

private let AuthenticationPathClientCredentials = "oauth/authorize/client"
private let AuthenticationPathAccessToken = "oauth/authorize/password"
private let AuthenticationPathUsers = "users"
private let AuthenticationPathFacebookToken = "oauth/authorize/facebook"
private let AuthenticationPathCodeGrant = "oauth/access_token"
private let AuthenticationPathPinCode = "oauth/device"
private let AuthenticationPathPinCodeAuthorize = "oauth/device/authorize"
private let AuthenticationPathAppTokenExchange = "oauth/appexchange"

// MARK: -

private let AuthenticationPathTokens = "/tokens"

typealias AuthenticationRequest = Request<VIMAccount>

extension Request where ModelType: VIMAccount
{
    /**
     Construct a `Request` for client credentials grant authentication
     
     - parameter scopes: an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func clientCredentialsGrantRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeClientCredentials,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: AuthenticationPathClientCredentials, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for code grant (redirect) authentication
     
     - parameter code:        the authorization code returned by the API
     - parameter redirectURI: the URI used to relaunch your application
     
     - returns: a new `Request`
     */
    static func codeGrantRequest(code code: String, redirectURI: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeAuthorizationCode,
                                                         CodeKey: code,
                                                         RedirectURIKey: redirectURI]
        
        return Request(method: .POST, path: AuthenticationPathCodeGrant, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for logging in with an email and password (Vimeo internal use only)
     
     - parameter email:    the user email
     - parameter password: the user password
     - parameter scopes:   an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func logInRequest(email email: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypePassword,
                                                         ScopeKey: Scope.combine(scopes),
                                                         UsernameKey: email,
                                                         PasswordKey: password]
        
        return Request(method: .POST, path: AuthenticationPathAccessToken, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for joining with a name, email, and password (Vimeo internal use only)
     
     - parameter name:     the new user name
     - parameter email:    the new user email
     - parameter password: the new user password
     - parameter scopes:   an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func joinRequest(name name: String, email: String, password: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         DisplayNameKey: name,
                                                         EmailKey: email,
                                                         PasswordKey: password]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for logging in with Facebook (Vimeo internal use only)
     
     - parameter facebookToken: the token returned by the Facebook SDK
     - parameter scopes:        an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func logInFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypeFacebook,
                                                         ScopeKey: Scope.combine(scopes),
                                                         TokenKey: facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathFacebookToken, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for joining with Facebook (Vimeo internal use only)
     
     - parameter facebookToken: the token returned by the Facebook SDK
     - parameter scopes:        an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func joinFacebookRequest(facebookToken facebookToken: String, scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [ScopeKey: Scope.combine(scopes),
                                                         TokenKey: facebookToken]
        
        return Request(method: .POST, path: AuthenticationPathUsers, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    /**
     Construct a `Request` for completing authentication on a connected device with a pin code (Vimeo internal use only)
     
     - parameter userCode:   the pin code presented to the user
     - parameter deviceCode: the device code returned by the api in the initial pin code request
     
     - returns: a new `Request`
     */
    static func authorizePinCodeRequest(userCode userCode: String, deviceCode: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [PinCodeKey: userCode,
                                                         DeviceCodeKey: deviceCode]
        
        return Request(method: .POST, path: AuthenticationPathPinCodeAuthorize, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
    
    public static func appTokenExchangeRequest(accessToken accessToken: String) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [AccessTokenKey: accessToken]
        
        return Request(method: .POST, path: AuthenticationPathAppTokenExchange, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
}

extension Request where ModelType: VIMNullResponse
{
    /**
     Construct a `Request` for deleting the current token
     
     - returns: a new `Request`
     */
    public static func deleteTokensRequest() -> Request
    {
        return Request(method: .DELETE, path: AuthenticationPathTokens, retryPolicy: .TryThreeTimes)
    }
}

// MARK: -

typealias PinCodeRequest = Request<PinCodeInfo>

extension Request where ModelType: PinCodeInfo
{
    /**
     Construct a `Request` for initiating authentication on a connected device with a pin code (Vimeo internal use only)
     
     - parameter scopes: an array of `Scope` values representing permissions your app requests
     
     - returns: a new `Request`
     */
    static func getPinCodeRequest(scopes scopes: [Scope]) -> Request
    {
        let parameters: VimeoClient.RequestParameters = [GrantTypeKey: GrantTypePinCode,
                                                         ScopeKey: Scope.combine(scopes)]
        
        return Request(method: .POST, path: AuthenticationPathPinCode, parameters: parameters, cacheFetchPolicy: .NetworkOnly, shouldCacheResponse: false)
    }
}