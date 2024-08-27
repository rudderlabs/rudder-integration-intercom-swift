source 'https://github.com/CocoaPods/Specs.git'
workspace 'RudderIntercom.xcworkspace'
use_frameworks!
inhibit_all_warnings!
platform :ios, '15.0'

def shared_pods
    pod 'Rudder', '~> 2.0.0'
end

target 'RudderIntercom' do
    project 'RudderIntercom.xcodeproj'
    shared_pods
    
end

target 'SampleAppObjC' do
    project 'Examples/SampleAppObjC/SampleAppObjC.xcodeproj'
    shared_pods
    pod 'RudderIntercom', :path => '.'
end

target 'SampleAppSwift' do
    project 'Examples/SampleAppSwift/SampleAppSwift.xcodeproj'
    shared_pods
    pod 'RudderIntercom', :path => '.'
end
