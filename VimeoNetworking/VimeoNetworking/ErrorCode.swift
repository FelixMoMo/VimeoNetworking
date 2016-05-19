//
//  ErrorCode.swift
//  VimeoNetworking
//
//  Created by Huebner, Rob on 4/25/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/// `VimeoErrorCode` contains all api error codes that are currently recognized by our client applications
public enum VimeoErrorCode: Int
{
    // Upload
    case UploadStorageQuotaExceeded = 4101
    case UploadDailyQuotaExceeded = 4102
    
    case InvalidRequestInput = 2204 // root error code for all invalid parameters errors below
    
    // Password-protected video playback
    case VideoPasswordIncorrect = 2222
    case NoVideoPasswordProvided = 2223
    
    // Authentication
    case EmailTooLong = 2216
    case PasswordTooShort = 2210
    case PasswordTooSimple = 2211
    case NameInPassword = 2212
    case EmailNotRecognized = 2217
    case PasswordEmailMismatch = 2218
    case NoPasswordProvided = 2209
    case NoEmailProvided = 2214
    case InvalidEmail = 2215
    case NoNameProvided = 2213
    case NameTooLong = 2208
    case FacebookJoinInvalidToken = 2303
    case FacebookJoinNoToken = 2306
    case FacebookJoinMissingProperty = 2304
    case FacebookJoinMalformedToken = 2305
    case FacebookJoinDecryptFail = 2307
    case FacebookJoinTokenTooLong = 2308
    case FacebookLogInNoToken = 2312
    case FacebookLogInMissingProperty = 2310
    case FacebookLogInMalformedToken = 2311
    case FacebookLogInDecryptFail = 2313
    case FacebookLogInTokenTooLong = 2314
    case FacebookInvalidInputGrantType = 2221
    case FacebookJoinValidateTokenFail = 2315
    case FacebookInvalidNoInput = 2207
    case FacebookInvalidToken = 2300
    case FacebookMissingProperty = 2301
    case FacebookMalformedToken = 2302
    case EmailAlreadyRegistered = 2400
    case EmailBlocked = 2401
    case EmailSpammer = 2402
    case EmailPurgatory = 2403
    case URLUnavailable = 2404
    case Timeout = 5000
    case TokenNotGenerated = 5001
}

/// `HTTPStatusCode` contains HTTP status code constants used to inspect response status
public enum HTTPStatusCode: Int
{
    case ServiceUnavailable = 503
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
}

/// `LocalErrorCode` contains codes for all error conditions that can be generated from within the library
public enum LocalErrorCode: Int
{
    // MARK: VimeoClient
    
    /// A response failed but returned no error object
    case Undefined = 9000
    
    /// A response returned successfully, but the response dictionary was not valid
    case InvalidResponseDictionary = 9001
    
    /// A request was not able to be initiated with the specified values
    case RequestMalformed = 9002
    
    /// A cache-only request found no cached response
    case CachedResponseNotFound = 9003
    
    // MARK: VIMObjectMapper
    
    /// No model object class was specified for deserialization
    case NoMappingClass = 9010
    
    /// Model object mapping was not successful
    case MappingFailed = 9011
    
    // MARK: AuthenticationController
    
    /// No access token was returned with a successful authentication response
    case AuthToken = 9004
    
    /// Could not retrieve parameters from code grant response
    case CodeGrant = 9005
    
    /// Code grant returned state did not match existing state
    case CodeGrantState = 9006
    
    /// No response was returned for an authenticationo request
    case NoResponse = 9007
    
    /// Pin code authentication did not return an activate link or pin code
    case PinCodeInfo = 9008
    
    /// The currently active pin code has expired
    case PinCodeExpired = 9009
    
    // MARK: AccountStore
    
    /// An account object could not be decoded from keychain data
    case AccountCorrupted = 9012
}