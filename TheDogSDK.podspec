Pod::Spec.new do |spec|

  spec.name         = "TheDogSDK"
  spec.version      = "1.0.0"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you integrate dogs api in your iOS apps.
                   DESC

  spec.homepage     = "https://github.com/KalpeshTalkar/TheDogSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Kalpesh" => "kalpeshtalkar@gmail.com" }

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5"

  spec.source        = { :git => "https://github.com/kalpeshtalkar/TheDogSDK.git", :tag => "#{spec.version}" }
  spec.source_files  = "TheDogSDK/**/*.{h,m,swift}"

end
