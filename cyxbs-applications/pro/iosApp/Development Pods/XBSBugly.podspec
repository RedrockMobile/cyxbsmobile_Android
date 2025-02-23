Pod::Spec.new do |s|
  s.name = 'XBSBugly'
  s.version = '0.1.0'
  s.summary = 'Cyxbs Networking'
  s.homepage = 'https://git.redrock.team/RedRock-iOS/NetWork'
  s.authors = { 'RedRock-iOS/NetWork' => 'https://git.redrock.team/RedRock-iOS' }
  s.source = { :git => 'https://git.redrock.team/RedRock-iOS/CyxbsMobile_iOS.git' }

  s.ios.deployment_target = '10.0'
  s.static_framework = true

  #s.swift_versions = ['5']

  s.source_files = 'XBSBugly/*.{h,m,swift}'

  s.dependency 'Bugly'
end