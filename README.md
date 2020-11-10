# PaystackCheckout

## Requirements

Paystack Checkout requires Xcode 11.7 or later and is compatible with apps targeting iOS 11 or above.

## Installation

PaystackCheckout is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PaystackCheckout'
```
Then run `pod install` from your project's directory on terminal.

## Usage

To collect payments from a user, create an instance of `CheckoutViewController` setting its `TransactionParams` and `delegate`.

```swift
let params = TransactionParams(amount: 5000, email: "test@email.com", key: "pk_live_xxxx")
let checkoutVC = CheckoutViewController(params: params, delegate: self)
present(checkoutVC, animated: true)

```
The `TransactionParams` class encapsulates all the parameters necessary to initialize a transaction. The following parameters are required `amount` `email` and `publicKey`. All others are optional. A full list of parameters and their function can be found [here](https://paystack.com/docs/api/#transaction-initialize). 

To receive events from the `CheckoutViewController` your presenting viewcontroller will need to conform to the `CheckoutProtocol`

```swift
class ViewController: UIViewController, CheckoutProtocol {

  func onSuccess(response: TransactionResponse) {
    print("Payment successfull \(response.reference)")
  }
  
  func onError(error: Error?) {
    print("There was an error: \(error!.localizedDescription)")
  }
    
  func onDimissal() {
    print("You dimissed the payment modal")
  }
}
```
