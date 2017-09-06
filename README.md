<h1 align="center">Starter</h1>

<p align="center">
  <a href="https://travis-ci.org/Blackjacx/SHSearchBar"><img alt="Build Status" src="http://img.shields.io/travis/Blackjacx/SHSearchBar.svg?style=flat"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar"><img alt="Version" src="https://cocoapod-badges.herokuapp.com/v/SHSearchBar/badge.svg"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="Supported Platforms" src="https://cocoapod-badges.herokuapp.com/p/SHSearchBar/badge.svg"/></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="License" src="https://img.shields.io/cocoapods/l/SHSearchBar.svg?style=flat"/></a>
  <a href="https://codecov.io/gh/blackjacx/SHSearchBar"><img alt="Codecov" src="https://codecov.io/gh/blackjacx/SHSearchBar/branch/master/graph/badge.svg"/></a>
  <a href="https://codebeat.co/projects/github-com-blackjacx-shsearchbar"><img alt="Codebeat" src="https://codebeat.co/badges/44539071-5029-4379-9d33-99dd721915c8" /></a>
  <a href="http://cocoadocs.org/docsets/SHSearchBar/"><img alt="Downloads" src="https://img.shields.io/cocoapods/dt/SHSearchBar.svg?maxAge=3600&style=flat" /></a>
</p>
 
This is a starting point that can be used to setup a new iOS project...

## Getting Started

### Clone this repository

    $ git clone git@github.com:blackjacx/starter.git

### CocoaPods

Third-party framework management is realized using [CocoaPods](http://cocoapods.org). This is a dependency manager for Cocoa and Cocoa 
Touch projects. Since Cocoapods is a ruby gem we decided to manage its installation and versioning using [bundler](http://bundler.io) - 
ruby's gem dependency manager. So you don't need to manually type `gem install cocoapods`. The Cocoapods & Gemfile guide is referenced 
[here](https://guides.cocoapods.org/using/a-gemfile.html). 
 
 First you need to install bundler:

    $ gem install bundler

 Next you change to the projects root dir and resolve the dependencies defined in the Gemfile by entering:

    $ cd <project_root_dir>
    $ bundle install

 Cocoapods creates a folder inside the root project directory - the Pods folder. This folder is not checked into the git repository. 
 So you need to initially install all pod dependencies using the following command in the projects root dir:

    $ cd <project_root_dir>
    $ bundle exec pod install

 > NOTE: If you use any tool that is installed using `bundler` don't forget to prefix the command with `bundle exec`. This is especially 
 important for the following commands: `pod`, `danger`

 > NOTE: If you have never installed Cocoapods before, you should move to a fast WiFi, because the first time the pod command will 
 download the Cocoapods Specs repository which has ~1GB! 

### Danger
 
Stop saying "you forgot to …" in code review!

Danger runs after your CI, automating your team's conventions surrounding code review. This provides another logical step in your process, through this Danger can help lint your rote tasks in daily code review. You can use Danger to codify your teams norms, leaving humans to think about harder problems.

Here are some dangerfiles that provide ideas in which situations danger can help you:

- https://github.com/danger/danger/blob/master/Dangerfile
- https://github.com/artsy/eigen/blob/master/Dangerfile

Setup Guide:

- http://danger.systems/guides/getting_started.html
- https://medium.com/developermind/using-swiftlint-and-danger-for-swift-best-practices-48432e4e268a

### SwiftLint

SwiftLint is the static code checker we use. It will be installed by Cocoapods and is configured by the file `.swiftlint.yml`. This tool can even auto-correct some issues and ensures that the code is and stays optimized regarding:

- performance
- style
- Swift language
- and many more ...

To run SwiftLint automatically on every build you have to add the following run script as the final build phase of your main target:

```shell
${PODS_ROOT}/SwiftLint/swiftlint autocorrect
${PODS_ROOT}/SwiftLint/swiftlint
```

## Development
 
Basically we develop on short living branches (one branch per task for example) to avoid extensive code reviews and merge conflicts after one or two weeks. If all tests are green (including your new written tests), you can create a pull request (PR). This PR is then reviewed by another developer and build by the CI. If all is fine and tests are green the PR can be merged onto `develop`.

Master branch should always be stable and deployable for hotfixes, if necessary. Merge from `develop` to `master`therefore happens only wen a new release is deployed.

### Coding Guidelines (ongiong)
1. **Use the `self.` syntax exclusively in closures and appropriate initializers.** So it will become easier to track down future retain cycles that are caused by missing `[weak self]` in the closure definition. Just leave out `self` if it is not necessary. Also use the `self.` syntax to initially assign constructor parameters to their respective properties if they have the same name.
1. **Never use the default case in switch statements.** Switch is an extremely useful construct in Swift since the compiler warns about missing cases. If you use the default case you disable this behaviour and loose one of the most powerful features of Swift.
1. **Never omit specifying the value of string-typed enum cases.** Imagine you create a string-typed enum and omit the values for every case since Swift infers the value from the case name. Now when you refactor one enum case from somewhere in your app, the inferred value also changes, which is not desired i.e. in JSON keys. You would introduce hard to find errors.
1. **Never directly edit localised files other than the base version.** The translations are managed centrally via Phrase - our translation service. If you always add translations manually to any of the string files other than `Base`, Phrase cannot infer untranslated keys.
1. **Create all classes as `final`.** This way some optimisations are enabled for these classes which speeds up compilation.
1. **Set thickness of lines device dependent.** When you set the thickness of lines to `1.0 / UIScreen.main.scale` then the will appear equally on all devices.
1. **Use UITextView for multiline text.** If you follow this rule you get text selection and all the features of an UITextView for free. Be sure you set isEditable and isScrollable to `false`.

### Review Guidelines (ongiong)
1. All tets must be green.
1. The coding guidelines must match.
1. Code duplicates are not allowed.

### User Defaults
 
 The project follows the swifty and safe approach to use iOS User Defaults that is explained in 
 [this article](http://radex.io/swift/nsuserdefaults/static/) and implemented in 
 [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults). 
 There are a bunch of reasons why this makes sense. Just read the article - it's worth it!

### CI & Testing
 
 [Bitrise](https://www.bitrise.io) is used for continuous integration. They build the project, develop, master branches as well as pull 
 requests automatically on their server. The workflow to execute tests locally is explained 
 [on their website](https://www.bitrise.io/cli). The key facts of bitrise are:
 
 * easy setup - (almost) zero maintenance
 * pull-request support
 * OTA app deployment and no need to have an account for testers
 * support for all popular services needed in iOS and Android development
 * command line support

### Interface Builder
 
 The next topic is the Interface Builder. Some love it others hate it. I personally made experiences in other projects that led me to the 
 decision to not use it in our iOS projects. To not let you stand in the rain you can read through the following reasons that 
 support that decision:
 
 * The loose coupling between storyboard and code leads to many optionals and you are forced to unwrap these by the use of a 
   lot of `guard` or `if let` statements 
 * Developing the UI in code improves the understanding of UIKit and AppKit
 * It is not easy to solve merge conflicts in Storyboards - this often leads to hard to find bugs that sometimes make it even in 
   production code
 * If you some day want to retire the storyboard in a large, grown project, you will be faced with a really time intensive task  
 * We all write code and we love our code - so for what reason should we drag and drop our UI components in place?
 * IBDesignable and IBInspectable are time killers - they slow down the compiler and their cost-benefit ratio is rather low 
 * Code-based auto layout meanwhile is really nice, easy to apply and many excellent frameworks make it even better  
 * The use of IB leads to copy and paste of views and view controllers - reuse in code on the other hand is clearly defined by 
   Design Patterns 
 * IB makes it hard to fix bugs since you now have to search in two different places for them
 * If you need to change fonts, colors, etc. you need to do this for *all* occurences - in code it is a one liner
 * IB forces you to implement multiple initializers - in code you just ignore init(withCoder:) and write less code
 * IB lets you configure just some properties, everything else is only available in code - why not configure everything in one place?
 
I took some of the above points from the following blogpost, which is a really interesting read about why to avoid IB: 
 [Life without Interface Builder](https://blog.zeplin.io/life-without-interface-builder-adbb009d2068#.shmcordh7)

## Author

<a href="mailto:stefan.herold@gmail.com">Stefan Herold</a>

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
