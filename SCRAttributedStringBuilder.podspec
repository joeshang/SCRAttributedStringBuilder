Pod::Spec.new do |s|

s.name         = "SCRAttributedStringBuilder"
s.version      = "1.1.1"
s.summary      = "Build NSAttributedString in chain"
s.description  = <<-DESC
SCRAttributedStringBuilder is a NSMutableAttributedString category which can build attributed string in chain, just like 'make' in Masonry, for simplying original redundant way.
DESC
s.homepage     = "https://github.com/joeshang/SCRAttributedStringBuilder"

s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Joe Shang" => "shangchuanren@gmail.com" }
s.source       = { :git => "https://github.com/joeshang/SCRAttributedStringBuilder.git", :tag => s.version.to_s }

s.ios.deployment_target = "8.0"
s.requires_arc = true
s.swift_version = '5.0'

s.default_subspec = 'All'

s.subspec 'All' do |ss|
  ss.dependency 'SCRAttributedStringBuilder/OC'
  ss.dependency 'SCRAttributedStringBuilder/Swift'
end

s.subspec 'OC' do |ss|
  ss.source_files = "Sources/Objective-C/**/*.{h,m}"
end

s.subspec 'Swift' do |ss|
  ss.source_files = "Sources/Swift/**/*.swift"
end

end
