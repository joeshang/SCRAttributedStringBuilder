# SCRAttributedStringBuilder

SCRAttributedStringBuilder 是一种链式构建 NSAttributedString 的库，参考 Masonry 中的链式思路，用于简化 NSAttributedString 冗长的构建和配置。

## 原理与使用

使用 Associated Object 的方式给 NSMutableAttributedString 增加一个 Range 数组，将方法分成 Content、Range、Attribute 三类，Content 和 Range 类的方法会影响 Attribute 的作用域（Range）。

使用方式如下：

```
NSString *text = @"测试多行文字链接测试多行文字链接测试多行文字测试多行文字链接测试多行文字";
self.label.attributedText = @"颜色/字体\n".attributedBuild.fontSize(30).color([UIColor purpleColor])
        .append(text).firstLineHeadIndent(20).lineHeight(25).paragraphSpacing(20)
        .match(@"链接").hexColor(0xFF4400).backgroundColor([UIColor lightGrayColor])
        .matchFirst(@"链接").underlineStyle(NSUnderlineStyleThick).underlineColor([UIColor greenColor])
        .matchLast(@"链接").strikethroughStyle(NSUnderlineStyleSingle).strikethroughColor([UIColor yellowColor])
        .append(text).alignment(NSTextAlignmentCenter).lineSpacing(10)
        .append(@"路飞").font([UIFont systemFontOfSize:25]).strokeWidth(2).strokeColor([UIColor darkGrayColor])
        .appendSizeImage([UIImage imageNamed:@"luffer"], CGSizeMake(50, 50))
```

具体见 Demo 工程和 `NSMutableAttributedString+SCRAttributedStringBuilder.h` 文件。

## 📲 安装

### CocoaPods 安装

为了将 SCRAttributedStringBuilder 集成到 Xcode 工程中，在 `Podfile` 中进行如下配置：

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!
target 'YourApp' do
	pod 'SCRAttributedStringBuilder'
end
```

之后运行以下命令：

```bash
$ pod install
```

### 手动安装

将 SCRAttributedStringBuilder 目录拖进工程中即可。

## 👨🏻‍💻 作者

Joe Shang, shangchuanren@gmail.com

## 👮🏻 许可证

SCRAttributedStringBuilder 使用 MIT License，更多请查看 LICENSE 文件。


