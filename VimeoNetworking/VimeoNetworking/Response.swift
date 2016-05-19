//
//  Response.swift
//  VimeoNetworkingExample-iOS
//
//  Created by Huebner, Rob on 4/5/16.
//  Copyright © 2016 Vimeo. All rights reserved.
//

import Foundation

/**
 *  `Response` represents a successful result returned by `VimeoClient` in fulfillment of a `Request`.
 */
 public struct Response<ModelType: MappableResponse>
{
        /// The parsed model object returned by the response
    public let model: ModelType
    
        /// The raw JSON dictionary returned by the response
    public let json: VimeoClient.ResponseDictionary
    
        /// Whether this `Response` was generated by a cache query
    public var isCachedResponse: Bool
    
        /// Whether this `Response` will be the final one received for it's associated `Request`
    public var isFinalResponse: Bool
    
        /// **(Not yet implemented)** The string path of the next page in this collection response, if it exists
    public let nextPagePath: String? // TODO: implement [RH] (4/5/16)
    
        /// **(Not yet implemented)** Generates the next page request for this collection response, if one exists
    public var nextPageRequest: Request<ModelType>?
    {
        return nil // TODO: computed from nextPagePath [RH] (4/5/16)
    }
    
    // MARK: - 
    
    /**
     Creates a new `Response`
     
     - parameter model:            The parsed model object returned by the response
     - parameter json:             The raw JSON dictionary returned by the response
     - parameter isCachedResponse: Whether this `Response` was generated by a cache query, defaults to false
     - parameter isFinalResponse:  Whether this `Response` will be the final one received for it's associated `Request`, defaults to true
     - parameter nextPagePath:     **(Not yet implemented)** The string path of the next page in this collection response, if it exists, defaults to nil
     
     - returns: an initialized `Response`
     */
    init(model: ModelType,
         json: VimeoClient.ResponseDictionary,
         isCachedResponse: Bool = false,
         isFinalResponse: Bool = true,
         nextPagePath: String? = nil)
    {
        self.model = model
        self.json = json
        self.isCachedResponse = isCachedResponse
        self.isFinalResponse = isFinalResponse
        self.nextPagePath = nextPagePath
    }
}