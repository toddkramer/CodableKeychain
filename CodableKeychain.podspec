Pod::Spec.new do |s|
  s.name = 'CodableKeychain'
  s.version = '0.8.0'
  s.license = 'MIT'
  s.summary = 'Swift framework for storing Codable conforming objects to the keychain.'
  s.homepage = 'https://github.com/toddkramer/CodableKeychain'
  s.social_media_url = 'http://twitter.com/_toddkramer'
  s.author = 'Todd Kramer'
  s.source = { :git => 'https://github.com/toddkramer/CodableKeychain.git', :tag => s.version }

  s.module_name = 'CodableKeychain'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'Sources/*.swift'
end
