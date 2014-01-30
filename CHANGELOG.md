# Changelog

**1.1.1**

 - Using `[UIColor lightGrayColor]` as default placeholder text color -- #8
 - Moving placeholder text view to the back to prevent cursor overlay -- #9
 - Removed `_placeholderLabel` as announced in 1.1.0
 - General cleanup

**1.1.0**

 - As of this release the placeholder is an instance of `UITextView` (instead of `UILabel`) which supports iOS 7's `exclusionPaths`, for example. If you have been using the private `_placeholderLabel` you will receive deprecation warnings. `_placeholderLabel` has been replaced with `_placeholderTextView` and will disappear in the next release.  [@Adrian2112]

**1.0.3**

 - Multiline placeholder support [@tcirwin]

**1.0.2**

 - Support for iOS 7's text container insets [@tcirwin]

**1.0.1**

 - Initializing the placeholder text so that it can be set via Interface Builder's "User Defined Runtime Attributes" [@ahalls]

**1.0.0**

 - Initial release

