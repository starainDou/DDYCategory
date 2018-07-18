# DDYCategory

* 链式编程 

```
UIViewNew.viewSetFrame(0, DDYTopH + 80, DDYScreenW, 30).viewBGColor([UIColor redColor]).viewAddToView(self.view);
```

* 设置UIButton 上图下文/上文下图/左图右文/左文右图

```
[button ddy_SetStyle:style padding:padding];
```

* UIAlertView block回调

```
[UIAlertView ddy_AlertTitle:@"0"
                        message:@"1"
                    cancelTitle:@"Cancel"
                     otherTitle:@"OK"
                clickIndexBlock:^(UIAlertView *alertView, NSInteger index) {
                    NSLog(@"%d", (int)index);
    }];
```

