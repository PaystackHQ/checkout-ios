//
//  PaymentParams.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/7/20.
//

import Foundation

public struct TransactionParams {
    /// Amount in lower denomination eg: kobo, peswa
    public var amount: Int
    /// Customer's email
    public var email: String
    /// Your business' public key found at https://dashboard.paystack.com/keys
    public var publicKey: String
    /// The customer's first name
    public var firstName: String?
    /// The customer's last name
    public var lastName: String?
    /// The customer's phone number
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
        self.publicKey = key
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
