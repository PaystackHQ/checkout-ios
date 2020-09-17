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
        self.presentationController?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addWebView()
        APIClient.shared.requestInline(params: params) { [weak self] response, error in
            guard let response = response else {
                // handle error
                return
            }
            print(response.url)
            let urlRequest = URLRequest(url: URL(string: response.url)!)
            self?.webView.load(urlRequest)
        }
    }
    
    func addWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.userContentController.add(self, name: "iosListener")
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func handleResponse(response: Any) {
        if let bodyDict = response as? [String : Any] {
            print(bodyDict)
            guard let event  = bodyDict["event"] as? String else { return }
            switch event {
            case TransactionEvents.close:
                delegate.onDimissal()
                dismiss(animated: true)
            case TransactionEvents.success:
                guard let response =  parseTransactionResponse(dict: bodyDict) else {
                    self.dismiss(animated: true)
                    delegate.onError(error: ErrorResponse.genericError)
                    return
                }
                delay(2){
                    self.dismiss(animated: true)
                    self.delegate.onSuccess(response: response)
                }
            default:
                break
            }
        }
    }
    
    func parseTransactionResponse(dict: [String : Any]) -> TransactionResponse?  {
        if let data = dict["data"] as? [String : Any] {
            guard let id = data["trans"] as? String, let reference = data["reference"] as? String else { return nil}
            return TransactionResponse(id: id, reference: reference)
        }
        return nil
    }
}

extension CheckoutViewController: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message received")
        if message.name == "iosListener" {
            handleResponse(response: message.body)
        }
    }
}

extension CheckoutViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        delegate.onDimissal()
    }
}

public protocol CheckoutDelegate {
    func onError(error: Error)
    func onSuccess(response: TransactionResponse)
    func onDimissal()
}

struct TransactionEvents {
    static let close = "close"
    static let success = "success"
    static let loadedCheckout = "loadedCheckout"
    static let loadedTransaction = "loadedTransaction"
    static let redirecting = "redirecting"
}

func delay(_ delay: Double, closure: @escaping () -> ()) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
