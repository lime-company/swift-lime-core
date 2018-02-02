Pod::Spec.new do |s|
  s.name = 'LimeCore'
  s.version = '0.9.0'
  # Metadata
  s.license = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.summary = 'Supporting classes developed and used by Lime - HighTech Solution'
  s.homepage = 'https://github.com/lime-company/swift-lime-core'
  s.social_media_url = 'https://twitter.com/lime_company'
  s.author = { 'Lime - HighTech Solution s.r.o.' => 'support@lime-company.eu' }
  s.source = { :git => 'https://github.com/lime-company/swift-lime-core.git', :tag => s.version }
  # Deployment targets
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  # Sources
  s.source_files = 'Source/*.swift'
end
