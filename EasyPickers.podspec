Pod::Spec.new do |s|
s.name = "EasyPickersCollection"
s.version = "1.0.0"
s.summary = "Collection of simple, extensible, easy to use pickers. Inspired by ActionSheetPicker."
s.homepage = "https://github.com/TimurBK/EasyPickersCollection"
s.license = { :type => 'MIT', :file => 'LICENSE' }
s.author = 'Timur Kuchkarov'
s.source = { :git => "https://github.com/TimurBK/EasyPickersCollection.git", :tag => s.version.to_s }
s.ios.deployment_target = '7.0'
s.source_files = 'EasyPickers'
s.requires_arc = true
s.dependency 'ReactiveCocoa', '~> 2.4'
end