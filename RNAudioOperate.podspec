require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name           = 'RNAudioOperate'
  s.version        = package['version']
  s.summary        = "RNAudioOperate"
  s.author         = "JamesWu"
  s.license        = "MIT"
  s.homepage       = "http://117.158.0.19:8081/package/react-native-audio-operate.git"
  s.source         = { :git => "http://117.158.0.19:8081/package/react-native-audio-operate.git", :tag => "v#{s.version}"}
  s.platform       = :ios, '8.0'
  s.preserve_paths = '*.js'
  s.frameworks     = 'AVFoundation'
  s.dependency 'React'
  s.source_files = 'ios/RNAudioOperate/*.{h,m}'

end
