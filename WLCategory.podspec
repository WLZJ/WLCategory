Pod::Spec.new do |s|
  s.name         = "WLCategory"
  s.version      = "1.0.1"
  s.license      = 'MIT'
  s.summary      = "常用类别"
  s.description  = <<-DESC
常用类别
                   DESC
  s.homepage     = "https://gitee.com"
  s.author             = { "WangLei(王雷)" => "wl20121212zj@163.com" }
  s.source       = { :git => "https://gitee.com/wlzj/WLCategory.git", :tag => "#{s.version}" }
  s.platform     = :ios
  s.source_files = "WLCategory/WLCategory/*.{h,m}"
  s.frameworks   = "UIKit", "Foundation"
end
