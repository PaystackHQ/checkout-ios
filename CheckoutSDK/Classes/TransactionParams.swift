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
    public var firstName: String?
    public var lastName: String?
    public var phone: String?
    public var reference: String?
    public var plan: String?
    public var invoiceLimit: Int?
    public var subAccount: String?
    public var transactionCharge: Int?
    public var bearer: String?
    public var metaData: String?
    public var quantity: Int?
    public var splitCode: String?
    public var label: String?
    public var currency: Currency?
    public var channels: [Channel]?
    
    public init(amount: Int, email: String, key: String, currency: Currency? = nil, firstName: String? = nil, lastName: String? = nil, phone: String? = nil, reference: String? = nil, plan: String? = nil, invoiceLimit: Int? = nil, subAccount: String? = nil, transactionCharge: Int? = nil, bearer: String? = nil, metaData: String? = nil, quantity: Int? = nil, splitCode: String? = nil, label: String? = nil, channels: [Channel]? = nil) {
        self.amount = amount
        self.email = email
        self.publicKey = key
        self.currency = currency
        self.reference = reference
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.invoiceLimit = invoiceLimit
        self.plan = plan
        self.subAccount = subAccount
        self.transactionCharge = transactionCharge
        self.bearer = bearer
        self.channels = channels
        self.metaData = metaData
        self.quantity = quantity
        self.splitCode = splitCode
        self.label = label
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
        case bankTransfer = "bank_transfer"
        case eft
    }
}
