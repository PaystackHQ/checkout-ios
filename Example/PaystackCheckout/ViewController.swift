//
//  ViewController.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 09/02/2020.
//  Copyright (c) 2020 Jubril Olambiwonnu. All rights reserved.
//

import UIKit
import PaystackCheckout

class ViewController: UIViewController, CheckoutProtocol {
    
    @IBOutlet var statusLabel: UILabel!
    override func viewDidLoad() {
        statusLabel.text = ""
        super.viewDidLoad()
    }
    
    @IBAction func onStartPaymentTap(_ sender: UIButton) {
        let paymentParams = TransactionParams(amount: 5000, email: "test@email.com", key: "pk_live_xxx", currency: .ngn, channels: [.qr, .ussd])
        let checkoutVC = CheckoutViewController(params: paymentParams, delegate: self)
        statusLabel.text = ""
        present(checkoutVC, animated: true)
    }
    
    func onError(error: Error?) {
        statusLabel.text = "There was an error: \(error!.localizedDescription)"
    }
    
    func onSuccess(response: TransactionResponse) {
        statusLabel.text = "Payment successfull \(response.reference)"
    }
    
    func onDimissal() {
        statusLabel.text = "You dimissed the payment modal"
    }
}

