//
//  AppDelegate.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/3.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var leftSide = SideController()
    
    var viewController = ViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        UINavigationBar.appearance().barTintColor = UIColor.blue.withAlphaComponent(0.5)
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().tintColor = UIColor.white
        window = UIWindow.init(frame: UIScreen.main.bounds)
        //window?.rootViewController = leftSide
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
        
        FilesPath().path()
        MachineModels().printDevice()
        //DateExpand().test()
        GCDExpond().getMain()
        GCDExpond().gcdTest()
        return true
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

extension AppDelegate {
    
    /*
     
     // 当应用程序启动完毕的时候就会调用(系统自动调用)
     application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
     
    // 即将失去活动状态的时候调用(失去焦点, 不可交互)
      - (void)applicationWillResignActive:(UIApplication *)application
     
      // 重新获取焦点(能够和用户交互)
      - (void)applicationDidBecomeActive:(UIApplication *)application
     
    // 应用程序进入后台的时候调用
    // 一般在该方法中保存应用程序的数据, 以及状态
      - (void)applicationDidEnterBackground:(UIApplication *)application
     
    // 应用程序即将进入前台的时候调用
    // 一般在该方法中恢复应用程序的数据,以及状态
    - (void)applicationWillEnterForeground:(UIApplication *)application
     
    // 应用程序即将被销毁的时候会调用该方法
    // 注意:如果应用程序处于挂起状态的时候无法调用该方法
    - (void)applicationWillTerminate:(UIApplication *)application
    
    // 应用程序接收到内存警告的时候就会调用
    // 一般在该方法中释放掉不需要的内存
    - (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
    
     */
    
    /*
     1、应用程序的状态
     状态如下：
     Not running   未运行  程序没启动
     Inactive      未激活  程序在前台运行，不过没有接收到事件。在没有事件处理情况下程序通常停留在这个状态
     Active        激活    程序在前台运行而且接收到了事件。这也是前台的一个正常的模式
     Backgroud     后台    程序在后台而且能执行代码，大多数程序进入这个状态后会在在这个状态上停留一会。时间到之后会进入挂起状态(Suspended)。有的程序经过特殊的请求后可以长期处于Backgroud状态
     Suspended     挂起    程序在后台不能执行代码。系统会自动把程序变成这个状态而且不会发出通知。当挂起时，程序还是停留在内存中的，当系统内存低时，系统就把挂起的程序清除掉，为前台程序提供更多的内存
     
    (1)点击桌面图标正常启动App或者杀死进程后点击推送消息启动App
        1.application:willFinishLaunchingWithOptions
    
        2.application:application:didFinishLaunchingWithOptions
    
        3.applicationDidBecomeActive
    
        4.application:didRegisterForRemoteNotificationsWithDeviceToken
    
    （2）拖下通知中心/双击Home键使App界面上移
        applicationWillResignActive
    
    （3）拖上通知中心/使App界面恢复原位
        applicationDidBecomeActive
    
    （4）按Home键使App进入后台
        1.applicationWillResignActive
    
        2.applicationDidEnterBackground
    
    （5）点击App图标，使App从后台恢复至前台
        1.applicationWillEnterForeground
    
        2.applicationDidBecomeActive
    
    （6）点击通知中心里面的远程推送，使App从后台进入前台
        1.applicationWillEnterForeground
    
        2.application:didReceiveRemoteNotification
    
        3.applicationDidBecomeActive
    
    （7）按住减号图标杀死App进程
        applicationWillTerminate
    
    （8）从APP切换到微信之类的其他应用之后，再切换回来时
        1.applicationWillEnterForeground
    
        2.application:openURL:sourceApplication
    
        3.applicationDidBecomeActive
     
     注:当程序处于后台时，点击推送消息进入前台会执行application:didReceiveRemoteNotification，但直接点击推送消息启动App是不会执行该didReceiveRemoteNotification的，在didFinishLaunchingWithOptions的options里面已经有数据表明当前是直接启动还是点击推送消息启动，localNotification与remote类似，略。
    */
    
}

