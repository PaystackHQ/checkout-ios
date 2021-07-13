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
    var headerView = UIView()
    var progressView = UIProgressView()
    public var params: TransactionParams
    public var delegate: CheckoutProtocol
    
    public init(params: TransactionParams, delegate: CheckoutProtocol) {
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
        addHeaderView()
        requestInline()
    }
    
    private func requestInline() {
        APIClient.shared.requestInline(params: params) { [weak self] response, error in
            guard let response = response else {
                self?.dismiss(animated: true)
                self?.delegate.onError(error: error)
                return
            }
            let urlRequest = URLRequest(url: URL(string: response.url)!)
            self?.webView.load(urlRequest)
        }
    }
    
    private func addHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        headerView.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1)
        let cancelIcon = UIImageView(image: UIImage.bundledImage(named: "cancel"))
        
        cancelIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cancelIcon)
        headerView.addSubview(progressView)
        progressView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        cancelIcon.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        cancelIcon.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        let cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cancelButton.addTarget(self, action: #selector(onCancelButtonTap), for: .touchUpInside)
    }
    
    private func addWebView() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.configuration.preferences.javaScriptEnabled = true
        webView.configuration.userContentController.add(self, name: "iosListener")
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)
    {
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: false)
        }
    }
    
    @objc func onCancelButtonTap() {
        delegate.onDimissal()
        dismiss(animated: true)
    }
    
    private func handleResponse(response: Any) {
        if let bodyDict = response as? [String : Any] {
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
                delay(2) { [weak self] in
                    self?.dismiss(animated: true)
                    self?.delegate.onSuccess(response: response)
                }
            default:
                break
            }
        }
    }
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    private func parseTransactionResponse(dict: [String : Any]) -> TransactionResponse?  {
        if let data = dict["data"] as? [String : Any] {
            guard let reference = data["reference"] as? String else {return nil}
            let id = data["trans"] as? String ??  String(data["trans"] as? Int ?? 0)
            return TransactionResponse(id: id, reference: reference)
        }
        return nil
    }
}

extension CheckoutViewController: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
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

public protocol CheckoutProtocol {
    func onError(error: Error?)
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

extension UIImage {
    class func bundledImage(named: String) -> UIImage? {
        let image = UIImage(named: named)
        if image == nil {
            return UIImage(named: named, in: Bundle(for: CheckoutViewController.classForCoder()), compatibleWith: nil)
        }
        return image
    }
}
