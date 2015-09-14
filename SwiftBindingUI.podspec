Pod::Spec.new do |s|

s.name         = "SwiftBindingUI"
s.version      = "1.1.3"
s.summary      = "A library of simple UI components built around the SwiftBinding library."

s.description  = <<-DESC
A library of the basic iOS UI components with added "binding" functionality built around the SwiftBinding library.
DESC

s.homepage     = "https://github.com/zacharyclaysmith/SwiftBindingUI"
s.license      = { :type => "MIT", :file => "LICENSE.md" }
s.author             = { "Zachary Clay Smith" => "Zachary.Clay.Smith@gmail.com" }
s.platform = :ios
s.ios.deployment_target = "8.0"

s.source       = { :git => "https://github.com/zacharyclaysmith/SwiftBindingUI.git", :tag => s.version }
s.source_files  = "SwiftBindingUI/**/*.swift"
s.dependency 'SwiftBinding'
s.requires_arc = true

end