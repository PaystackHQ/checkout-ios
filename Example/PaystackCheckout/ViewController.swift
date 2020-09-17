//
//  ViewController.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 09/02/2020.
//  Copyright (c) 2020 Jubril Olambiwonnu. All rights reserved.
//

import UIKit
import PaystackCheckout

class ViewController: UIViewController, CheckoutDelegate {
    
    @IBOutlet var statusLabel: UILabel!
    override func viewDidLoad() {
        statusLabel.text = ""
        super.viewDidLoad()
    }
    
    @IBAction func onStartPaymentTap(_ sender: UIButton) {
        let paymentParams = PaymentParams(amount: 500, email: "email", key: "pk_xxx")
        let checkoutVC = CheckoutViewController(params: paymentParams, delegate: self)
        statusLabel.text = ""
        present(checkoutVC, animated: true)
    }
    
    func onError(error: Error) {
        statusLabel.text = "There was an error: \(error.localizedDescription)"
        print("There was an error: \(error.localizedDescription)")
    }
    
    func onSuccess(response: TransactionResponse) {
        statusLabel.text = "Payment successfull \(response.reference)"
        print("Payment successfull \(response.reference)")
    }
    
    func onDimissal() {
        statusLabel.text = "You dimissed the payment modal"
        print("payment modal dismissed")
    }
}

