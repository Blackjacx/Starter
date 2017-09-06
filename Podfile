platform :ios, '10.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target 'Starter' do
    pod 'SwiftLint'
    pod 'Fabric'
    pod 'Crashlytics'

    target 'StarterTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
    end

    target 'StarterUITests' do
        inherit! :search_paths
    end
end
