# AceCuteView
仿手机QQ消息提示小红点，拖拉黏性动画消除

使用方法很简单

    
```
#import "AceCuteView.h"

AceCuteView *view = [[AceCuteView alloc] initWithFrame:CGRectMake(50, 50, 40, 25)];
//黏性距离，不设置默认50，允许设置范围30~90
view.viscosity = 90;
//需要显示的文字
view.bubbleText = @"55";
//小圆点背景色，默认是红色
view.bgColor = [UIColor redColor];
[self.view addSubview:view];
```

![demo](https://github.com/linushao/AceCuteView/blob/master/01.gif)
