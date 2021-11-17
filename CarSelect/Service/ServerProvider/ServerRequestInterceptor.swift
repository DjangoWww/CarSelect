//
//  ServerRequestInterceptor.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import Alamofire

/// ServerRequestInterceptor
public struct ServerRequestInterceptor: RequestInterceptor {

    private let _prepare: ((URLRequest) -> URLRequest)?
    private let _willSend: ((URLRequest) -> Void)?

    init(prepare: ((URLRequest) -> URLRequest)? = nil,
         willSend: ((URLRequest) -> Void)? = nil) {
        _prepare = prepare
        _willSend = willSend
    }

    public func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (AFResult<URLRequest>) -> Void
    ) {
        let request = _prepare?(urlRequest) ?? urlRequest
        _willSend?(request)
        completion(.success(request))
    }
}
