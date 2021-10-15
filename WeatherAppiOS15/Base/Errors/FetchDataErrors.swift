//
//  FetchDataErrors.swift
//  WeatherAppiOS15
//
//  Created by Sebastian Maludziński on 12/10/2021.
//

import SwiftUI

enum FetchDataErrors: LocalizedError {
    case wrongURL, wrongServerResponse, dataDecodingError
    
    public var errorDescription: String? {
        switch self {
        case .wrongURL: return NSLocalizedString("Wrong URL.", comment: "")
        case .wrongServerResponse: return NSLocalizedString("Wrong server response.", comment: "")
        case .dataDecodingError: return NSLocalizedString("Error when decoding data.", comment: "")
        }
    }
}
