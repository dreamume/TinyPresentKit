Pod::Spec.new do |s|
  s.name     = 'TinyPresentKit'
  s.version  = '1.0.0'
  s.license  = { :type => 'MIT' }
  s.summary  = 'A simple framework for showing modal view or view controller'
  s.authors  = 'dreamume'
  s.homepage = "https://github.com/dreamume/TinyPresentKit"
#  s.source   = { :git => 'https://github.com/dreamume/TinyPresentKit.git', :tag => "v#{ s.version.to_s }" }
  s.source   = { :git => 'https://github.com/dreamume/TinyPresentKit.git', :branch => "master" }
  s.swift_version = '4.2'
  s.source_files = 'TinyPresentKit/*.{swift,h}'
  s.ios.deployment_target = '8.0'
end
