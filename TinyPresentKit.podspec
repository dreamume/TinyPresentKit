# coding: utf-8
Pod::Spec.new do |spec|

  spec.name         = "TinyPresentKit"
  spec.version      = "1.0.1"
  spec.summary      = "A simple framework for showing modal view controller"
  spec.description  = "A simple framework for showing modal view controller, simple api"
  spec.homepage     = "https://github.com/dreamume/TinyPresentKit"
  spec.license      = { :type => 'MIT' }
  spec.author       = { "dreamume" => "dreamume@gmail.com" }
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/dreamume/TinyPresentKit.git", :tag => "#{spec.version}" }
  spec.source_files = "TinyPresentKit/*.{swift,h}"
  spec.requires_arc = true
  spec.swift_version = "4.2"
  spec.ios.frameworks = "UIKit", "Foundation"

end
