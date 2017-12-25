#
#  Be sure to run `pod spec lint MaterialColors.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         	= "MaterialColors"
  s.version      	= "2.0.0"
  s.summary      	= "Implementation of Material Design Colors in Swift 4."
  s.description  	= <<-DESC
  						Everything you need to use the Google Material Design Colors.
  						Includes the various colors in groupings and both 
  						by static name and string lookup.
  						Fun for the whole family.
                   		 DESC
  s.homepage     	= "https://github.com/dpyro/MaterialColors"
  s.screenshots  	= "https://raw.githubusercontent.com/dpyro/MaterialColors/master/screenshot.png",
  s.license      	= { :type => "MIT", :file => "LICENSE" }
  s.author          = { "Sumant Manne" => "sumant.manne@gmail.com" }
  s.social_media_url= "http://twitter.com/SumantManne"
  s.platform     	= :ios, "8.0"
  s.source       	= { :git => "https://github.com/dpyro/MaterialColors.git", :tag => "#{s.version}" }
  s.source_files  	= "MaterialColors/*.{h,swift}"
  s.requires_arc 	= true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end
