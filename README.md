 
###预备工作
 
1. **项目引入框架 CoreLocation.framework**
 
2. **在使用文件中导入头文件**

		#import <CoreLocation/CoreLocation.h>

###CLLocationManager位置管理器使用

 1. **创建位置管理器属性（设置强引用，防止销毁）**
		
		@property (nonatomic ,strong) CLLocationManager *mgr;

 2. **初始化创建位置管理器对象**
		
		self.mgr = [CLLocationManager new];

 3.  **授权处理**
 
	**获取授权状态**
	
	```
		/*
		kCLAuthorizationStatusNotDetermined = 0,    //用户从未选择过权限
     	kCLAuthorizationStatusRestricted,           //无法使用定位服务，该状态用户无法改变
     	kCLAuthorizationStatusDenied,               //用户拒绝该应用使用定位服务，或是定位服务总开关处于关闭状态
     	kCLAuthorizationStatusAuthorizedAlways,     //用户允许该程序无论何时都可以使用地理信息
     	kCLAuthorizationStatusAuthorizedWhenInUse,  //用户同意程序在可见时使用地理位置
     	kCLAuthorizationStatusAuthorized            //已经授权（废弃）使用kCLAuthorizationStatusAuthorizedAlways
		*/
	
    	CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
	
	```
 	
 	**判断授权，请求授权**
 	
 	```
 		if(
       		authorizationStatus != kCLAuthorizationStatusAuthorizedAlways &&
       		authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse
    	) {
        // 用户同意程序在可见时使用才能获取地理位置信息
        if([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.mgr requestWhenInUseAuthorization];
        }
        // 允许程序无论何时都可以使用地理信息
        /*
        if([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [self.mgr requestAlwaysAuthorization];
        }
        */
    }
 		
 	```
 	**配置info.plist**
 	
 	添加NSLocationWhenInUseUsageDescription
 	
 	添加NSLocationAlwaysUsageDescription
 	
 4. **设置代理**
 
 		self.mgr.delegate = self;
 		
 	实现获取定位信息的代理方法
 	
 	```
 		- (void)locationManager:(CLLocationManager *)manager
     		 didUpdateLocations:(NSArray<CLLocation *> *)locations {
    		
    	} 
	```
 5. **开始定位**
 	
 		[self.mgr startUpdatingLocation];
 		
 6. **根据应用决定是否获取定位信息后关闭定位功能**

		[self.mgr stopUpdatingLocation];
		
 7. **在持续定位情况下降低电量消耗（可选）**
 
 ```
 	// 可选 为了降低点亮消耗设置距离筛选区 米单位
    self.mgr.distanceFilter = 5;
    
    // 可选 为了降低点亮消耗设置精准度
    /*
    kCLLocationAccuracyBestForNavigation    //导航专用
    kCLLocationAccuracyBest                 //最精准，默认
    kCLLocationAccuracyNearestTenMeters     //十米
    kCLLocationAccuracyHundredMeters        //百米
    kCLLocationAccuracyKilometer            //千米
    kCLLocationAccuracyThreeKilometers      //三千米
     */
    self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
 
 ```