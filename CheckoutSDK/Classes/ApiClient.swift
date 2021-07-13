
import Alamofire
import UIKit
import WebKit

public class APIClient {
    public static var shared = APIClient()
    let url = "https://api.paystack.co/checkout/request_inline"
    
    public func requestInline(params: TransactionParams, completion: @escaping (PaymentResponse?, Error?) -> Void) {
         let params: [String : Any?] = [
            "amount" : params.amount,
            "email" : params.email,
            "key" : params.publicKey,
            "firstname" : params.firstName,
            "lastname" : params.lastName,
            "phone" : params.phone,
            "plan" : params.plan,
            "invoice_limit" : params.invoiceLimit,
            "subaccount" : params.subAccount,
            "transaction_charge" : params.transactionCharge,
            "ref" : params.reference,
            "split_code" : params.splitCode,
            "quantity" : params.quantity,
            "metadata" : params.metaData,
            "label" : params.label,
            "bearer" : params.bearer,
            "currency" : params.currency?.rawValue,
            "channels" : params.channels?.map{$0.rawValue}
        ]
        
        let cleanParams = params.compactMapValues{$0}
        AF.request(url, parameters: cleanParams, encoding: URLEncoding.default).responseData { response in
            switch response.result {
            case .success(let json):
                guard let paymentResponse = try? JSONDecoder().decode(PaymentResponse.self, from: json) else {
                    let error = try? JSONDecoder().decode(ErrorResponse.self, from: json)
                    completion(nil, error)
                    return
                }
                completion(paymentResponse, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}



