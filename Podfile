source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!

target 'PocketSVG_Animation' do
  pod 'PocketSVG'
  pod 'Macaw', '0.8.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end