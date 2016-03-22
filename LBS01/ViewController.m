//
//  ViewController.m
//  实现一次定位
//
//  Created by zhuwei on 16/3/22.
//  Copyright © 2016年 zhuwei. All rights reserved.
//

#import "ViewController.h"

// 1. 导入头文件
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic)   CLLocationManager   *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 2. 创建位置管理器（设置强引用，防止销毁）
    self.mgr = [CLLocationManager new];
    
    // 3. 授权处理
    // 3.1 获取授权状态
    /*
     kCLAuthorizationStatusNotDetermined = 0,    //用户从未选择过权限
     kCLAuthorizationStatusRestricted,           //无法使用定位服务，该状态用户无法改变 Restricted: 受限制
     kCLAuthorizationStatusDenied,               //用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态 Denied: 拒绝
     kCLAuthorizationStatusAuthorizedAlways,     //用户允许该程序无论何时都可以使用地理信息 iOS8
     kCLAuthorizationStatusAuthorizedWhenInUse,  //用户同意程序在可见时使用地理位置 iOS8
     kCLAuthorizationStatusAuthorized            //已经授权（废弃）使用 kCLAuthorizationStatusAuthorizedAlways
     */
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    // 3.2 判断授权状态
    if(
       authorizationStatus != kCLAuthorizationStatusAuthorizedAlways &&
       authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse
       ) {
        // 3.3 请求授权
        // 3.3.1 用户同意程序在可见时使用才能获取地理位置信息
        if([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.mgr requestWhenInUseAuthorization];
        }
        // 3.3.2 允许程序无论何时都可以使用地理信息
        if([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.mgr requestAlwaysAuthorization];
        }
    }
    // 3.3 配置info.plist
    // 添加 NSLocationWhenInUseUsageDescription
    // 添加 NSLocationAlwaysUsageDescription
    
    // 4. 设置代理
    self.mgr.delegate = self;
    
    // 4.1 实现代理方法获取定位信息
    
    
    // 可选 为了降低点亮消耗设置距离筛选区 米单位
//    self.mgr.distanceFilter = 5;
    
    // 可选 为了降低点亮消耗设置精准度
    /*
     kCLLocationAccuracyBestForNavigation    //导航专用
     kCLLocationAccuracyBest                 //最精准，默认
     kCLLocationAccuracyNearestTenMeters     //十米
     kCLLocationAccuracyHundredMeters        //百米
     kCLLocationAccuracyKilometer            //千米
     kCLLocationAccuracyThreeKilometers      //三千米
     */
//    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 5. 启动定位
    [self.mgr startUpdatingLocation];
    
    
    
}

#pragma mark - 获取定位信息代理回调 -
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"locations:%@",locations);
    // 6. 根据应用决定是否获取定位信息后关闭定位功能
    [self.mgr stopUpdatingLocation];
}

@end
