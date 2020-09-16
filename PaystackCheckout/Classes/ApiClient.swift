
import Alamofire
import UIKit
import WebKit

public class APIClient {
    public static var shared = APIClient()
    let url = "https://studio-api.paystack.co/checkout/request_inline"
    
    public func requestInline(params: PaymentParams, completion: @escaping (PaymentResponse?, Error?) -> Void) {
        let params: [String : Any] = [
            "amount" : params.amount,
            "email" : params.email,
            "key" : params.key,
        ]
        AF.request(url, parameters: params, encoding: URLEncoding.default).responseData { response in
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


