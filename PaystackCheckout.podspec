#
# Be sure to run `pod lib lint PaystackCheckout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PaystackCheckout'
  s.version          = '0.1.0'
  s.summary          = 'A drop in library to accept payment with Paystack on iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A drop in library to accept payment with Paystack on iOS'
  s.homepage         = 'https://github.com/Jubril Olambiwonnu/PaystackCheckout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jubril Olambiwonnu' => 'jubril@paystack.com' }
  s.source           = { :git => 'https://github.com/Jubril Olambiwonnu/PaystackCheckout.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_versions = '5.0'

  s.source_files = 'PaystackCheckout/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PaystackCheckout' => ['PaystackCheckout/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Alamofire'
end
