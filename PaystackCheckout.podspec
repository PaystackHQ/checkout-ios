#
# Be sure to run `pod lib lint PaystackCheckout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PaystackCheckout'
  s.version          = '0.1.1'
  s.summary          = 'A drop in library to accept payment with Paystack on iOS'
  s.description      = 'A drop in library to accept payment with Paystack on iOS. This is the easiest way to start collecting payments on your mobile apps.'
  s.homepage         = 'https://github.com/PaystackHQ/checkout-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jubril Olambiwonnu' => 'jubril@paystack.com' }
  s.source           = { :git => 'https://github.com/PaystackHQ/checkout-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'

  s.source_files = 'CheckoutSDK/Classes/**/*'
  
   s.resource_bundles = {
     'PaystackCheckout' => ['CheckoutSDK/Assets/*.xcassets']
   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Alamofire'
end
