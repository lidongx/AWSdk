#
#  Be sure to run `pod spec lint AWSdk.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "AWSdk"
  spec.version      = "1.0.6"
  spec.summary      = "A short description of AWSdk."


  spec.homepage     = "https://github.com/lidongx/AWSdk"



  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  #spec.license      = "MIT"
 spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  spec.author             = { "lidong" => "lidong@smalltreemedia.com" }
  # Or just: spec.author    = "lidong"
 spec.authors            = { "lidong" => "lidong@smalltreemedia.com" }
  # spec.social_media_url   = "https://twitter.com/lidong"

   spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/lidongx/AWSdk.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  #spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  #spec.exclude_files = "Classes/Exclude"

	
  #spec.source_files  = "AWSdk", "AWSdk/**/*.{h,m}"
  #spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"

  spec.ios.vendored_frameworks = "AWSdk.framework"



  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"

spec.static_framework = true


spec.frameworks = "AdSupport","AudioToolbox","AVFoundation","AddressBook","CoreGraphics","CoreData","CoreLocation","CoreTelephony","CoreMotion","CoreMedia","CFNetwork","EventKit","EventKitUI","MediaPlayer","MessageUI","MobileCoreServices","PassKit","QuartzCore","Social","StoreKit","Security","SystemConfiguration","Foundation"

spec.weak_frameworks = 'Twitter',"WebKit","JavaScriptCore","WatchConnectivity"

  #spec.frameworks = "Crashlytics", "Fabric","GoogleMobileAds"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"



 spec.libraries = "z", "xml2","z.1.2.5","sqlite3","sqlite3.0","c++"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }




  spec.dependency 'Firebase', '6.1.0'
  spec.dependency 'Firebase/Analytics'
  spec.dependency 'Firebase/Performance'
  spec.dependency 'Firebase/Core'
  spec.dependency 'Firebase/Messaging'
  spec.dependency 'Firebase/Storage'
  spec.dependency 'Firebase/RemoteConfig'
  spec.dependency 'FirebaseInAppMessaging','0.14.0'
  spec.dependency 'FirebaseInAppMessagingDisplay'
  spec.dependency 'Fabric'
  spec.dependency 'Crashlytics'
  spec.dependency 'Google-Mobile-Ads-SDK'

  spec.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/Firebase/Analytics'
    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
  }


end
