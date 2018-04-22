Pod::Spec.new do |s|

s.name         = "SCRAttributedStringBuilder"
s.version      = "1.0.0"
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

s.source_files = "SCRAttributedStringBuilder/*.{h,m}"
s.frameworks = 'Foundation', 'UIKit'

end
