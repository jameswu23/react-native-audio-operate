require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|

  s.name           = 'RNAudioOperate'
  s.version        = package['version']
  s.summary        = "RNAudioOperate"
  s.author         = "JamesWu"
  s.license        = "MIT"
  s.homepage       = "https://github.com/jameswu23/react-native-audio-operate.git"
  s.source         = { :git => "https://github.com/jameswu23/react-native-audio-operate.git", :tag => "v#{s.version}"}
  s.platform       = :ios, '8.0'
  s.preserve_paths = '*.js'
  s.frameworks     = 'AVFoundation'
  s.dependency 'React'
  s.source_files = 'ios/RNAudioOperate/*.{h,m}'

end
