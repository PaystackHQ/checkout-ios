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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onStartPaymentTap(_ sender: UIButton) {
        let paymentParams = PaymentParams(amount: 30, email: "test@email.com", key: "PK_XXXXXX")
        let checkoutVC = CheckoutViewController(params: paymentParams, delegate: self)
        present(checkoutVC, animated: true)
    }
    
    func onError(error: Error) {
        print("There was an error: \(error.localizedDescription)")
    }
    
    func onSuccess(ref: String) {
        print("Payment successfull \(ref)")
    }
    
}

