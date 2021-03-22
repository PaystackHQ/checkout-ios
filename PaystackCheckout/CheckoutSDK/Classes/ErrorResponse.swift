//
//  ErrorResponse.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/16/20.
//

import Foundation

public struct ErrorResponse: Error, CustomStringConvertible {
    public var description: String {return message}
    let message: String
    static let genericError = ErrorResponse(message: "Error parsing response")
    enum CodingKeys: String, CodingKey {
        case message
    }
}

extension ErrorResponse: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
    }
}

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(message, comment: "")
    }
}
