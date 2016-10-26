//
//  SZTextViewSwift.swift
//  SZTextView
//
//  Created by Jackie Meggesto on 9/19/16.
//
//

import Foundation


func HAS_TEXT_CONTAINER(x: AnyObject) -> Bool {
    return x.respondsToSelector(Selector("textContainer"))
}
func HAS_TEXT_CONTAINER_INSETS(x: AnyObject) -> Bool {
    return x.respondsToSelector(Selector("textContainerInset"))
}
class SZTextViewSwift: UITextView {
    
    var _placeHolder: String?
    var _attributedPlaceholder: NSAttributedString?
    
    @IBInspectable var placeholder: String? {
        
        get {
            return _placeHolder
        }
        set(newValue) {
            
            _placeHolder = newValue
            _attributedPlaceholder = NSAttributedString(string: newValue!)
            resizePlaceholderFrame()
        }
        
    }
    var attributedPlaceholder: NSAttributedString? {
        
        get {
            return _attributedPlaceholder
        }
        set(newValue) {
            _placeHolder = newValue?.string
            _attributedPlaceholder = newValue?.copy() as? NSAttributedString
            resizePlaceholderFrame()
        }
        
    }
    
    @IBInspectable var fadeTime: Double?
    
    var placeholderTextColor: UIColor? {
        
        get {
            return _placeholderTextView?.textColor
        }
        set(newValue) {
            _placeholderTextView?.textColor = newValue
        }
        
    }
    
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
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
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
        
        if (self._placeholderTextView!.respondsToSelector("selectable")) {
            self._placeholderTextView?.selectable = false
        }
        
        if (HAS_TEXT_CONTAINER(self)) {
            self._placeholderTextView?.textContainer.exclusionPaths = self.textContainer.exclusionPaths;
            self._placeholderTextView?.textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding;
        }
        if (HAS_TEXT_CONTAINER_INSETS(self)) {
           self._placeholderTextView?.textContainerInset = self.textContainerInset;
        }
        if (attributedPlaceholder != nil) {
            self._placeholderTextView?.attributedText = attributedPlaceholder;
        } else if (placeholder != nil ) {
            self._placeholderTextView?.text = placeholder;
        }
        
        self.setPlaceHolderVisibleForText(self.text)
        
        self.clipsToBounds = true
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SZTextViewSwift.textDidChange(_:)), name: UITextViewTextDidChangeNotification, object: self)
        
        self.addObserver(self, forKeyPath: kAttributedPlaceholderKey, options: .New, context: nil)
        self.addObserver(self, forKeyPath: kPlaceholderKey, options: .New, context: nil)
        self.addObserver(self, forKeyPath: kFontKey, options: .New, context: nil)
        self.addObserver(self, forKeyPath: kAttributedTextKey, options: .New, context: nil)
        self.addObserver(self, forKeyPath: kTextKey, options: .New, context: nil)
        self.addObserver(self, forKeyPath: kTextAlignmentKey, options: .New, context: nil)
        
        if(HAS_TEXT_CONTAINER(self)) {
            self.textContainer.addObserver(self, forKeyPath: kExclusionPathsKey, options: .New, context: nil)
            self.textContainer.addObserver(self, forKeyPath: kLineFragmentPaddingKey, options: .New, context: nil)
        }
        if(HAS_TEXT_CONTAINER_INSETS(self)) {
            self.addObserver(self, forKeyPath: kTextContainerInsetKey, options: .New, context: nil)
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        resizePlaceholderFrame()
    }
    

    func textDidChange(notification: NSNotification) {
        self.setPlaceHolderVisibleForText(self.text)
    }
    
    func resizePlaceholderFrame() {
        
        guard var frame = _placeholderTextView?.frame else {
            return
        }
        frame.size = self.bounds.size
        self._placeholderTextView?.frame = frame
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if (keyPath == kAttributedPlaceholderKey) {
            if let attributedString = change?[NSKeyValueChangeNewKey] as? NSAttributedString {
                self._placeholderTextView?.attributedText = attributedString
            }
        }
        if (keyPath == kPlaceholderKey) {
            if let placeholderString = change?[NSKeyValueChangeNewKey] as? String {
                self._placeholderTextView?.text = placeholderString
            }
        }
        if (keyPath == kFontKey) {
            if let font = change?[NSKeyValueChangeNewKey] as? UIFont {
                self._placeholderTextView?.font = font
            }
        }
        if (keyPath == kAttributedTextKey) {
            if let attributedString = change?[NSKeyValueChangeNewKey] as? NSAttributedString {
                setPlaceHolderVisibleForText(attributedString.string)
            }
        }
        if (keyPath == kTextKey) {
            if let newText = change?[NSKeyValueChangeNewKey] as? String {
                self.setPlaceHolderVisibleForText(newText)
            }
        }
        if (keyPath == kExclusionPathsKey) {
            if let exclusionPaths = change?[NSKeyValueChangeNewKey] as? [UIBezierPath] {
                self._placeholderTextView?.textContainer.exclusionPaths = exclusionPaths
                resizePlaceholderFrame()
            }
        }
        if (keyPath == kLineFragmentPaddingKey) {
            if let paddingValue = change?[NSKeyValueChangeNewKey] as? CGFloat {
                self._placeholderTextView?.textContainer.lineFragmentPadding = paddingValue
                resizePlaceholderFrame()
            }
        }
        if (keyPath == kTextContainerInsetKey) {
            if let value = change?[NSKeyValueChangeNewKey] as? NSValue {
                self._placeholderTextView?.textContainerInset = value.UIEdgeInsetsValue();
            }
        }
        if (keyPath == kTextAlignmentKey) {
            
            if let alignment = change?[NSKeyValueChangeNewKey] as? NSTextAlignment {
                self._placeholderTextView?.textAlignment = alignment
            }
        }
        
        
    }
    
    override func becomeFirstResponder() -> Bool {
        
        setPlaceHolderVisibleForText(self.text)
        return super.becomeFirstResponder()
    }
    
    func setPlaceHolderVisibleForText(text: String) {
        if text.characters.count < 1 {
            
            if self.fadeTime > 0.0 {
                if(self._placeholderTextView?.isDescendantOfView(self) == false) {
                    self._placeholderTextView?.alpha = 0
                    self.addSubview(self._placeholderTextView!)
                    self.sendSubviewToBack(self._placeholderTextView!)
                }
                UIView.animateWithDuration(fadeTime!, animations: { 
                    self._placeholderTextView?.alpha = 1
                })
            }
            else {
                self.addSubview(self._placeholderTextView!)
                self.sendSubviewToBack(self._placeholderTextView!)
                self._placeholderTextView?.alpha = 1
            }
        }
        else {
            if (self.fadeTime > 0.0) {
                UIView.animateWithDuration(fadeTime!, animations: { 
                    self._placeholderTextView?.alpha = 0
                })
            }
            else {
                self._placeholderTextView?.removeFromSuperview()
            }
        }
    }

}
