//
//  WebViewController.swift
//  PaystackCheckout
//
//  Created by Jubril Olambiwonnu on 9/8/20.
//

import UIKit
import WebKit

public class CheckoutViewController: UIViewController {

    var webView = WKWebView()
    public var params: PaymentParams
    public var delegate: CheckoutDelegate
    var viewModel = CheckoutViewModel()
   
    public init(params: PaymentParams, delegate: CheckoutDelegate) {
        self.params = params
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addWebView()
        APIClient.shared.requestInline(params: params)
    }
    
    func addWebView() {

        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

public protocol CheckoutDelegate {
    func onError(error: Error)
    func onSuccess(ref: String)
}
