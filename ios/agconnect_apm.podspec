Pod::Spec.new do |s|
  s.name             = 'agconnect_apm'
  s.version          = '1.4.0+300'
  s.summary          = 'HUAWEI AGC APM Kit plugin for Flutter.'
  s.description      = <<-DESC
  App Performance Management (APM) of HUAWEI AGC provides minute-level app performance monitoring capabilities.
                       DESC
  s.homepage         = 'https://developer.huawei.com/consumer/en/agconnect/'
  s.license          =  { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Huawei AGConnect' => 'agconnect@huawei.com' }
  s.source           = { :git => '' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'AGConnectAPM' ,'1.2.1.302'
  s.platform = :ios, '9.0'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
