platform :ios, '9.0'
use_frameworks!

target 'OkCupidProject' do
    pod 'Alamofire', '3.5.1'
    pod 'SwiftyJSON', '2.4.0'
end

target 'OkCupidProjectTests' do

end

target 'OkCupidProjectUITests' do

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
