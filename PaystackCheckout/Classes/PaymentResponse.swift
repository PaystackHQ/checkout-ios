//
//  PaymentResponse.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/14/20.
//

import Foundation
import Alamofire

public struct PaymentResponse {
    var accessCode: String
    var url: String {
        return "http://checkout.paystack.com/\(accessCode)"
    }
    
    enum CodingKeys: String, CodingKey {
        case data
        case accessCode = "access_code"
    }
}

extension PaymentResponse: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.accessCode = try data.decode(String.self, forKey: .accessCode)
    }
}
