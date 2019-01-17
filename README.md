# InfiniteSpringBoard
锤子科技无限屏的iOS实现

## 效果展示
通过在越狱环境下修改SpringBoard.app，实现了一个iOS桌面的无限屏模式，实拍效果如下:
![](https://user-gold-cdn.xitu.io/2018/8/24/1656c7844421c5e6?w=512&h=290&f=gif&s=4083845)

## 掘金原文
[https://juejin.im/post/5b801cede51d4538a108af56](https://juejin.im/post/5b801cede51d4538a108af56)

### 配置

0. 安装[MonkeyDev](https://github.com/AloneMonkey/MonkeyDev)，作为越狱开发的自动化工具链
1. 打开Xcode工程
2. 打开UltimateSpringBoard Target的Build Settings，配置User-Defined的Settings中的MonkeyDevDeviceIP、Port等信息，这些信息用于在Theos构建后自动将deb传输和安装到手机
3. 将工程根目录下的`arch/UltimateSpringBoard.bundle`利用scp命令传输到`/Library/MobileSubstrate/DynamicLibraries/`目录，这些是插件需要访问的资源
4. 为SpringBoard.app的Info.plist添加`NSCameraUsageDescription`权限
5. Build工程即可完成安装

### 手动编译和安装
- 工程的Packages目录中包含了编译好的deb包，可以直接体验
- UltimateSpringBoard.xm是Logos主文件，可以用Theos手动编译

## 感想
也许无限屏并不能带来什么，但是这个探索过程是十分有趣的，希望本文能够帮助那些好奇无限屏实现原理和想要实践越狱插件开发的同学们。
