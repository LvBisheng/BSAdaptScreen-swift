# BSAdaptScreen-swift

根据当前屏幕来等比例缩放UI元素，例如字体，约束，圆角等。

使用：
1. cocopods导入，命令： pod 'BSAdaptScreen-swift'

2. 在启动app的时候进行配置缩放策略，例如在AppDelegate 的 didFinishLaunchingWithOptions方法里面调用
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        BSAdaptScreenConfig.config { (floatValue) -> (CGFloat) in
            // 在这里面配置想要的缩放策略
            
            // 不缩放
            //return floatValue
            
            // 如果屏幕宽度小于基准屏幕就不缩放，否则进行放大
//            if UIScreen.main.bounds.size.width >= kRefereWidth {
//                return floatValue
//            }
            
            // 根据根据屏幕宽度来缩放
            return floatValue * UIScreen.main.bounds.size.width/kRefereWidth
        }
        return true
    }
```
3. 例如给controller上的view进行缩放(缩放的方式有：约束constraint、字体fontSize、圆角cornerRadius、目前支持的所有方式all)：
```
view.adaptScreenWidth(type: .all)
```

