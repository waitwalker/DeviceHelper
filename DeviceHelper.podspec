#
# Be sure to run `pod lib lint DeviceHelper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.metadata['allowed_push_host'] = 'https://github.com'
  s.name             = 'DeviceHelper'
  s.version          = '0.1.0'
  s.summary          = 'Devicehelper is used to get the device type.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Devicehelper is used to get the device type.获取设备相关参数的辅助类,不需要传入任何参数即可获取到设备信息.
                       DESC

  s.homepage         = 'https://github.com/waitwalker/DeviceHelper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'waitwalker' => 'waitwalker@163.com' }
  s.source           = { :git => 'https://github.com/waitwalker/DeviceHelper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'DeviceHelper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DeviceHelper' => ['DeviceHelper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
