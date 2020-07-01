Pod::Spec.new do |s|
  s.name         = "BSAdaptScreen-swift" 
  s.version      = "1.0.1"        
  s.license      = "MIT"          
  s.summary      = "A UIView extension" 

  s.homepage     = "https://github.com/LvBisheng/BSAdaptScreen-swift" 
  s.source       = { :git => "https://github.com/LvBisheng/BSAdaptScreen-swift.git", :tag => "#{s.version}" }
  s.source_files = "BSAdaptScreen-swift/*.{swift}" 
  s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "8.0" 
  s.frameworks   = "UIKit", "Foundation" 
  
  # User
  s.author             = { "LBS" => "victory.lv@foxmail.com" } 
  s.social_media_url   = "https://github.com/LvBisheng" 

end