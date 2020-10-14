//
//  PaymentParams.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/7/20.
//

import Foundation

public struct TransactionParams {
    public var amount: Int
    public var email: String
    public var key: String
    public var firstName: String?
    public var lastName: String?
    public var phone: String?
    public var plan: String?
    public var invoiceLimit: Int?
    public var subAccount: String?
    public var transactionCharge: Int?
    public var bearer: String?
    public var currency: Currency?
    public var channels: [Channel]?
    
    public init(amount: Int, email: String, key: String, currency: Currency? = nil, firstName: String? = nil, lastName: String? = nil, phone: String? = nil, plan: String? = nil, invoiceLimit: Int? = nil, subAccount: String? = nil, transactionCharge: Int? = nil, bearer: String? = nil, channels: [Channel]? = nil) {
        self.amount = amount
        self.email = email
        self.key = key
        self.currency = currency
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.invoiceLimit = invoiceLimit
        self.plan = plan
        self.subAccount = subAccount
        self.transactionCharge = transactionCharge
        self.bearer = bearer
        self.channels = channels
    }
    
    public enum Currency: String {
        case ngn = "NGN"
        case ghs = "GHS"
        case zar = "ZAR"
        case usd = "USD"
    }
    
    public enum Channel: String {
        case card
        case bank
        case ussd
        case qr
        case mobileMoney = "mobile_money"
    }
}
