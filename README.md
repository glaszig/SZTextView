# SZTextView

A drop-in UITextView replacement which gives you: a placeholder.  
Technically it differs from other solutions in that it tries to work like UITextField's private `_placeholderLabel` so you should not suffer ugly glitches like jumping text views or loads of custom drawing code.

## Requirements

Your iOS project. (Tested on iOS versions 5.0 and 6.1)

## Installation

The easiest way would be to clone this repo and add the project to your Xcode workspace.  
Or use [CocoaPods](http://cocoapods.org).

## Usage

```objc
SZTextView *textView = [SZTextView new];
self.textView.placeholder = @"Enter lorem ipsum here";
self.textView.placeholderTextColor = [UIColor lightGrayColor];
self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
```

A simple demo is included.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# License

Published under the [MIT license](http://opensource.org/licenses/MIT).
