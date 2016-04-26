 

<h1 align="center"> CardDeepLinkKit</h1>


<p align="center">
<a href="https://travis-ci.org/button/DeepLinkKit"><img src="http://img.shields.io/travis/button/DeepLinkKit.svg?style=flat" alt="CI Status" /></a>
<a href='https://coveralls.io/github/button/DeepLinkKit?branch=master'><img src='https://coveralls.io/repos/github/button/DeepLinkKit/badge.svg?branch=master' alt='Coverage Status' /></a>
<a href="http://cocoadocs.org/docsets/DeepLinkKit"><img src="https://img.shields.io/cocoapods/v/DeepLinkKit.svg?style=flat" alt="Version" /></a>
<a href="http://cocoadocs.org/docsets/DeepLinkKit"><img src="https://img.shields.io/cocoapods/l/DeepLinkKit.svg?style=flat" alt="License" /></a>
<a href="http://cocoadocs.org/docsets/DeepLinkKit"><img src="https://img.shields.io/cocoapods/p/DeepLinkKit.svg?style=flat" alt="Platform" /></a>
</p>

## Overview

CardDeepLinkKit is a splendid route-matching, block-based way to handle your deep links. Rather than decide how to format your URLs, parse them, pass data, and navigate to specific content or perform actions, this library and a few lines of code will get you on your way.
 

## Installation

DeepLinkKit is available through [CocoaPods](http://cocoapods.org). To install
the library, simply add the following line to your Podfile:
```ruby
pod "CardDeepLinkKit"
```

If you don't use CocoaPods, you can include all of the source files from the [CardDeepLinkKit directory]() in your project.

## Usage
Add deep link support to your app in 5 minutes or less following these simple steps.
 
[http://7xq9bx.com1.z0.glb.clouddn.com/1.pic.jpg](http://7xq9bx.com1.z0.glb.clouddn.com/1.pic.jpg)


<br /><br />
**1. Make sure you have a URL scheme registered for your app in your Info.plist**
<img src="https://cloud.githubusercontent.com/assets/1057077/5710380/8d913f3e-9a6f-11e4-83a2-49f6564d7a8f.png" width="410" />

<br />
**2. Import DeepLinkKit**

```objc
#import <CardDeepLinkKit/CardDeepLinkKit-swift.h>
or
import CardDeepLinkKit
```
<br />
**3. Create an instance of `CDDeepLinkRouter` in your app delegate**

````objc

private lazy var router: CDDeepLinkRouter = CDDeepLinkRouter()

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
       return true
}
````
<br />
**4. Register a route handler**

````objc
  router.registerBlock({ (deeplink) in
            debugPrint("deeplink2 \(deeplink)")
            }, route: "/say2/:desc")
or
router.registerHandlerClass(TestProductRouteHandler.self, route: "/say")
````
<br />
**5. Pass incoming URLs to the router**

```objc
func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        
        router.handleURL(url) { (complte, error) in
            debugPrint("info : \(complte)")
        }
        
        return true
    }
```
**6. Passing `NSUserActivity` objects to the router** (optional)
<br/>
_**Note:** If your application supports [Apple's new universal links](https://developer.apple.com/library/prerelease/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-DontLinkElementID_2), implement the following in your app delegate:_

```objc
- (BOOL)application:(UIApplication *)application
        continueUserActivity:(NSUserActivity *)userActivity
          restorationHandler:(void (^)(NSArray *))restorationHandler {

    return [self.router handleUserActivity:userActivity withCompletion:NULL];
}
```



Learn more about the DeepLinkKit by reading our [Integration Guide]().

## Route Registration Examples

URLs coming into your app will be in a similar format to the following:
`<scheme>://<host>/<path-component>/<path-component>`

When registering routes, it's important to note that the first forward slash in your registered route determines the start of the path to be matched. A route component before the first forward slash will be considered to be the host.

Say you have an incoming URL of `twitter://timeline`

```objc

// Matches the URL.
router[@"timeline"] = ^{ … }

// Does not match the URL.
router[@"/timeline"] = ^{ … }
```

In another example, a URL of `cddpl://asiainfo.com/timeline`

```objc
// Matches the URL.
router[@"/timeline"] = ^{ … }

// Does not match the URL.
router[@"timeline"] = ^{ … }

```

You can also be scheme specific. If you support multiple URL schemes in your app, you can register routes specific to those schemes as follows:

An incoming URL of `scheme-one://timeline`

```objc
// Matches the URL.
router[@"scheme-one://timeline"] = ^{ … }

// Does not match the URL.
router[@"scheme-two://timeline"] = ^{ … }
```

### Regex Route Matching
You can use regex in your route patterns as well to give you maximum flexibility.

**Match any url**

_The following will match all incoming urls_
```objc
router[@".*"] ^(DPLDeepLink *link){
  // This will match all incoming links
}
```
_**Note:** Routes are matched in the order they're registered so registering this route first will prevent all other more specific routes from matching._

**Match any url with a given scheme**

_The following will match all incoming links with the scheme, `myscheme://`_
```objc
router[@"myscheme://.*"] ^(DPLDeepLink *link){
  // matches all urls with a scheme of `myscheme://`
}
```

**You can name your regex groups too**

_The following will match any url with a `host` of `trycaviar.com` and hand you `:path` in the route params._
```objc
// Given the url ‘https://trycaviar.com/manhattan/nicoletta-297`
router[@"trycaviar.com/:path(.*)"] ^(DPLDeepLink *link){
  // `link[@"path"]` => @"manhattan/nicoletta-297"
}
```

**Match multiple path components**

_In this example, you'll get `:city` and `:restaurant` in the route params._
```objc
// Given the url ‘https://trycaviar.com/manhattan/nicoletta-297`
router[@"trycaviar.com/:city([a-zA-Z]+)/:restaurant(.*)"] ^(DPLDeepLink *link){
  // `link[@"city"]` => @"manhattan"
  // `link[@"restaurant"]` => @"nicoletta-297"
}
```
_If the restaurant ids are numbers, you could limit your matches as follows._
```objc
// Given the url ‘https://trycaviar.com/manhattan/297`
router[@"trycaviar.com/:city([a-zA-Z]+)/:restaurant([0-9])"] ^(DPLDeepLink *link){
  // `link[@"city"]` => @"manhattan"
  // `link[@"restaurant"]` => @"297"
}
```

**Name some groups and not others**
```objc
// Lets say the url is ‘https://trycaviar.com/manhattan/pizza/nicoletta-297`
router[@"trycaviar.com/:city([a-zA-Z]+)/[a-z]+/:restaurant(.*)"] ^(DPLDeepLink *link){
  // `link[@"city"]` => @"manhattan"
  // `link[@"restaurant"]` => @"nicoletta-297"
}
```
_The above would match ‘https://trycaviar.com/manhattan/pizza/nicoletta-297’ but not ‘https://trycaviar.com/manhattan/PIZZA/nicoletta-297’ or ‘https://trycaviar.com/manhattan/pizza-places/nicoletta-297’, etc_

## AppLinks Support

Does your app support AppLinks? You can easily handle incoming AppLinks by importing the AppLinks category `DPLDeepLink+AppLinks`. The AppLinks category provides convenience accessors to all AppLinks 1.0 properties.

```objc
router[@"/timeline"] = ^(DPLDeepLink *link) {
  NSURL *referrerURL  = link.referralURL;
  NSString *someValue = link.extras[@"some-key"];
}
```

## Running the Demo

To run the example project, run `pod try DeepLinkKit` in your terminal. You can also clone the repo, and run `pod install` from the project root. If you don't have CocoaPods, begin by [follow this guide](http://guides.cocoapods.org/using/getting-started.html).

There are two demo apps, `SenderDemo`, and `ReceiverDemo`. `ReceiverDemo` has some registered routes that will handle specific deep links. `SenderDemo` has a couple actions that will deep link out to `ReceiverDemo` for fulfillment.

Run the`SenderDemo` build scheme first, then stop the simulator and switch the build scheme to `ReceiverDemo` and run again. Now you can switch back to the `SenderDemo` app in the simulator and tap on one of the actions.


## Creating Deep Links

You can also create deep links with `DPLMutableDeepLink`. Between two `DeepLinkKit` integrated apps, you can pass complex objects via deep link from one app to another app and easily get that object back on the other end.

In the first app:

```objc

DPLMutableDeepLink *link = [[DPLMutableDeepLink alloc] initWithString:@"app-two://categories"];
link[@"brew-types"] = @[@"Ale", @"Lager", @"Stout", @"Wheat"]
link[@"beers"] = @{
  @"ales": @[
    @{
        @"name": @"Southern Tier Pumking Ale",
        @"price": @799
    },
    @{
        @"name": @"Sierra Nevada Celebration Ale",
        @"price": @799
    }
  ],
  @"lagers": @[
     ...
  ],
  ...
}

[[UIApplication sharedApplication] openURL:link.URL];

```

In the second app:

```objc
router[@"categories"] = ^(DPLDeepLink *link) {
  NSArray *brewTypes  = link[@"brew-types"];
  NSDictionary *beers = link[@"beers"];
}
```


## Authors

[Nicolas Tinkl](http://twitter.com/tinkl)<br /> 

## License

DeepLinkKit is available under the MIT license. See the LICENSE file for more info.

## Contributing

We'd love to see your ideas for improving this library. The best way to contribute is by submitting a pull request. We'll do our best to respond to you as soon as possible. You can also submit a new Github issue if you find bugs or have questions. :octocat:

Please make sure to follow our general coding style and add test coverage for new features!
