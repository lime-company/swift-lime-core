Pod::Spec.new do |s|
  s.name = 'LimeCore'
  s.version = '0.9.4'
  # Metadata
  s.license = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.summary = 'Supporting classes developed and used by Lime - HighTech Solution'
  s.homepage = 'https://github.com/lime-company/swift-lime-core'
  s.social_media_url = 'https://twitter.com/lime_company'
  s.author = { 'Lime - HighTech Solution s.r.o.' => 'support@lime-company.eu' }
  s.source = { :git => 'https://github.com/lime-company/swift-lime-core.git', :tag => s.version }
  # Deployment targets
  s.swift_version = '4.0'
  s.ios.deployment_target = '8.0'
  s.watchos.deployment_target = '2.0'
  # Sources
  
  # Default subspec should include all source codes provided in core except 'LimeCore/LocalizedString' pod
  # Currently 'Localization' fulfills this requirement due to its transitional dependencies. 
  s.default_subspec = 'Localization'
  
  # 'Core' subspec
  s.subspec 'Core' do |sub|
    sub.source_files = 'Source/Core/*.swift'
  end
  
  # 'Config' subspec
  s.subspec 'Config' do |sub|
    sub.source_files = 'Source/Config/*.swift'
    sub.dependency 'LimeCore/Core'
  end

  # 'Localization' subspec
  s.subspec 'Localization' do |sub|
    sub.source_files = 'Source/Localization/*.swift'
    sub.dependency 'LimeCore/Config'
  end
  
  # 'LocalizedString' subspec
  s.subspec 'LocalizedString' do |sub|
    sub.source_files = 'Source/LocalizedString/*.swift'
    sub.dependency 'LimeCore/Localization'
  end

end
