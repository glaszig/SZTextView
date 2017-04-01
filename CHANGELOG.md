# Changelog

**1.3.0**

 - Allow use in application extensions -- #55 [@simonboots]
 - Upgraded target platform to 8.0. Older versions are now unsupported.

**1.2.2**

 - Carthage support -- #36 [@iv-mexx]

**1.2.1**

 - Support for fadding animation for placeholder -- #34 [@jaropawlak]

**1.2.0**

 - Supporting IBInspectable for `placeholder` and IB_DESIGNABLE -- #23, #32 [@MoathOthman]
 - Improved default placeholder color -- #30 [@erf]
 - Properly syncing inset and offset configured in interface builder

**1.1.10**

 - Fixing handling of `contentInset` and `contentOffset` for text views configured in IB or setup in code. See #21. [@pjs7678]

**1.1.9**

 - Supporting the new (iOS 7) initializer `initWithFrame:textContainer:` -- #20 [@vlas-voloshin]

**1.1.8**

 - Syncing `textAlignment` property -- #18 [@arturgrigor]

**1.1.7**

 - Actually copying properties in setters instead of just assigning them -- #17 [@xuki]

**1.1.6**

 - Sync text view's and placeholder's `contentInset` and `contentOffset` -- #16 [@RyanBertrand]

**1.1.5**

 - Properly allow usage of User Defined Runtime Attributes in Interface Builder -- #15 [@paulz]

**1.1.4**

 - Fixing issue with the placeholder only appearing when the text view is tapped/focussed (e.g. becomes the first responder) -- #14 [@SellJamHere]

**1.1.3**

 - Support `attributedPlaceholder` for fancy placeholder texts -- #13 [@benlachman]

**1.1.2**

 - Properly hiding the placeholder view if it awakes from nib and the text property is not empty -- #12 [@yangshengchaoios]
 - Keeping the text container's `lineFragmentPadding` in sync -- #11 [@benlachman]
 - Keeping track of `textContainerInset` upon `-awakeFromNib` -- #10 [@vlas-voloshin]

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

