//
//  NetworkErrors.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 8/29/24.
//

import Foundation
    enum NetworkError: Error {
        case invalidURL
        case requestFailed(String)
        case responseParsingFailed
        case serverError(String)
        case unknownError
    }
