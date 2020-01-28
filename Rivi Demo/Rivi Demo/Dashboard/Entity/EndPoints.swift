//
//  EndPoints.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Food: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "guljar-rivi/server/db"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(EnvironmentURL.baseUrl)\(path)"
            }
        }
    }
}
