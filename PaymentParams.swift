//
//  PaymentParams.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/7/20.
//

import Foundation

public struct PaymentParams {
    public var amount: Int
    public var email: String
    public var key: String
    
    public init(amount: Int, email: String, key: String) {
        self.amount = amount
        self.email = email
        self.key = key
    }
}
