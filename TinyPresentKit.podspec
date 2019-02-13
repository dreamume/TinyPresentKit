Pod::Spec.new do |s|
  s.name     = 'TinyPresentKit'
  s.version  = '1.0.1'
  s.license  = { :type => 'MIT' }
  s.summary  = 'A simple framework for showing modal view controller'
  s.authors  = 'dreamume'
  s.homepage = "https://github.com/dreamume/TinyPresentKit"
  s.source   = { :git => 'https://github.com/dreamume/TinyPresentKit.git', :tag => s.version.to_s }
  s.swift_version = '4.2'
  s.source_files = 'TinyPresentKit/*.{swift,h}'
  s.ios.deployment_target = '9.0'
end
