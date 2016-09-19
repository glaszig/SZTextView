//
//  SZTextViewSwift.swift
//  SZTextView
//
//  Created by Jackie Meggesto on 9/19/16.
//
//

import Foundation

class SZTextViewSwift: UITextView {
    
    
    /*
     property (copy, nonatomic) IBInspectable NSString *placeholder;
     property (nonatomic) IBInspectable double fadeTime;
     property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
     property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;
 
    */
    
    @IBInspectable var placeholder: String?
    @IBInspectable var fadeTime: Double?
    var attributedPlaceholder: NSAttributedString?
    var placeholderTextColor: UIColor?
    
    var _placeholderTextView: UITextView?
    
    let kAttributedPlaceholderKey = "attributedPlaceholder";
    let kPlaceholderKey = "placeholder";
    let kFontKey = "font";
    let kAttributedTextKey = "attributedText";
    let kTextKey = "text";
    let kExclusionPathsKey = "exclusionPaths";
    let kLineFragmentPaddingKey = "lineFragmentPadding";
    let kTextContainerInsetKey = "textContainerInset";
    let kTextAlignmentKey = "textAlignment";
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.preparePlaceholder()
    }
    
    func preparePlaceholder() {
        
        assert(self._placeholderTextView == nil, "placeholder has been prepared already: \(self._placeholderTextView)")
        
        let frame = self.bounds
        self._placeholderTextView = UITextView(frame:frame)
        self._placeholderTextView?.opaque = false
        self._placeholderTextView?.backgroundColor = UIColor.clearColor()
        self._placeholderTextView?.textColor = UIColor.init(white: 0.7, alpha: 0.7)
        self._placeholderTextView?.textAlignment = self.textAlignment;
        self._placeholderTextView?.editable = false
        self._placeholderTextView?.scrollEnabled = false
        self._placeholderTextView?.userInteractionEnabled = false
        self._placeholderTextView?.font = self.font;
        self._placeholderTextView?.isAccessibilityElement = false
        self._placeholderTextView?.contentOffset = self.contentOffset;
        self._placeholderTextView?.contentInset = self.contentInset;
        
        if self._placeholderTextView!.respondsToSelector("selectable") {
            self._placeholderTextView?.selectable = false
        }
        
    }
    
    /*
     - (void)preparePlaceholder

     
     if ([self._placeholderTextView respondsToSelector:@selector(setSelectable:)]) {
     self._placeholderTextView.selectable = NO;
     }
     
     if (HAS_TEXT_CONTAINER) {
     self._placeholderTextView.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
     self._placeholderTextView.textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
     }
     
     if (HAS_TEXT_CONTAINER_INSETS(self)) {
     self._placeholderTextView.textContainerInset = self.textContainerInset;
     }
     
     if (_attributedPlaceholder) {
     self._placeholderTextView.attributedText = _attributedPlaceholder;
     } else if (_placeholder) {
     self._placeholderTextView.text = _placeholder;
     }
     
     [self setPlaceholderVisibleForText:self.text];
     
     self.clipsToBounds = YES;
     
     // some observations
     NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
     [defaultCenter addObserver:self selector:@selector(textDidChange:)
     name:UITextViewTextDidChangeNotification object:self];
     
     [self addObserver:self forKeyPath:kAttributedPlaceholderKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:kPlaceholderKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:kFontKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:kAttributedTextKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:kTextKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:kTextAlignmentKey
     options:NSKeyValueObservingOptionNew context:nil];
     
     if (HAS_TEXT_CONTAINER) {
     [self.textContainer addObserver:self forKeyPath:kExclusionPathsKey
     options:NSKeyValueObservingOptionNew context:nil];
     [self.textContainer addObserver:self forKeyPath:kLineFragmentPaddingKey
     options:NSKeyValueObservingOptionNew context:nil];
     }
     
     if (HAS_TEXT_CONTAINER_INSETS(self)) {
     [self addObserver:self forKeyPath:kTextContainerInsetKey
     options:NSKeyValueObservingOptionNew context:nil];
     }
     }
    */
    
    
    
}