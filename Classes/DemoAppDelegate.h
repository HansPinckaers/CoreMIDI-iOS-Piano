
@class DemoViewController;

@interface DemoAppDelegate : NSObject <UIApplicationDelegate>
{
	UIWindow* window;
	DemoViewController* viewController;
}

@property (nonatomic) IBOutlet UIWindow* window;
@property (nonatomic) IBOutlet DemoViewController* viewController;

@end
