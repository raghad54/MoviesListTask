import UIKit

private var textFieldUnderlineActive: [UITextField: UIColor] = [:]
private var textFieldUnderline: [UITextField: UIColor] = [:]

extension UIImage {
    func flipHorizontally(rad: CGFloat = .pi/2) -> UIImage {
        if Localizer.current == .arabic {
            return self
        } else {
            let flippedImage = self.withHorizontallyFlippedOrientation()
            return flippedImage
        }
        //        var radians = rad
        //        if Localizer.current == .arabic {
        //            radians = .pi*2
        //        } else {
        //            radians = rad
        //        }
        //        let rotatedSize = CGRect(origin: .zero, size: size)
        //            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
        //            .integral.size
        //        UIGraphicsBeginImageContext(rotatedSize)
        //        if let context = UIGraphicsGetCurrentContext() {
        //            let origin = CGPoint(x: rotatedSize.width / 2.0,
        //                                 y: rotatedSize.height / 2.0)
        //            context.translateBy(x: origin.x, y: origin.y)
        //            context.rotate(by: radians)
        //            draw(in: CGRect(x: -origin.y, y: -origin.x,
        //                            width: size.width, height: size.height))
        //            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        //            UIGraphicsEndImageContext()
        //            return rotatedImage ?? self
        //        }
        //        return self
    }
}

extension UINavigationItem {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            self.title = newValue.localized
        }
    }
}
extension UILabel {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            self.text = newValue.localized
        }
    }
}
extension UIButton {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            self.setTitle(newValue.localized, for: .normal)
        }
    }
    public func controlAlignment() {
        if(self.titleLabel?.textAlignment != .center) {
            if Localizer.current == .arabic {
                self.titleLabel?.textAlignment = .right
            } else {
                self.titleLabel?.textAlignment = .left
            }
        }
    }
    public func controlImageEdge() {
        if Localizer.current == .arabic {
            if(self.imageEdgeInsets.right > 0) {
                self.imageEdgeInsets.left = self.imageEdgeInsets.right
                self.imageEdgeInsets.right = 0
            } else if(self.imageEdgeInsets.left > 0) {
                self.imageEdgeInsets.right = self.imageEdgeInsets.left
                self.imageEdgeInsets.left = 0
            }
            if(self.titleEdgeInsets.right > 0) {
                self.titleEdgeInsets.left = self.titleEdgeInsets.right
                self.titleEdgeInsets.right = 0
            } else if(self.titleEdgeInsets.left > 0) {
                self.titleEdgeInsets.right = self.titleEdgeInsets.left
                self.titleEdgeInsets.left = 0
            }
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var localizationImage: Bool {
        get {
            return self.localizationImage
        } set {
            print(newValue)
            self.controlImageEdge()
            let image = self.image(for: .normal)
            self.setImage(image?.flipHorizontally(), for: .normal)
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var localizationBackGroundImage: Bool {
        get {
            return self.localizationBackGroundImage
        } set {
            print(newValue)
            let image = self.backgroundImage(for: .normal)
            self.setBackgroundImage(image?.flipHorizontally(), for: .normal)
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var imageEdgeChecker: Bool {
        get {
            return self.imageEdgeChecker
        }
        set {
            if(newValue) {
                self.controlImageEdge()
            }
        }
    }
}
extension UIImageView {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: Bool {
        get {
            return self.localization
        } set {
            print(newValue)
            let image = self.image
            self.image = image?.flipHorizontally()
        }
    }
}

extension UIBarButtonItem {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            if(self.image != nil) {
                self.image = UIImage(named: newValue.localized)
            } else {
                self.title = newValue.localized
            }
        }
    }
}

extension UITabBarItem {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            self.title = newValue.localized
        }
    }
}

extension UITextField {
    public func controlAlignment() {
        if(self.textAlignment != .center) {
            if Localizer.current == .arabic {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localizationPlaceHolder: String {
        get {
            return self.localizationPlaceHolder
        }
        set {
            self.placeholder = newValue.localized
            controlAlignment()
        }
    }
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var localization: String {
        get {
            return self.localization
        }
        set {
            self.text = newValue.localized
            controlAlignment()
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var underline: UIColor? {
        get {
            return self.underline
        }
        set {
            if newValue != nil {
                //self.underlined(color: newValue!)
                self.addBottomBorder(withColor: newValue!)
                textFieldUnderline[self] = newValue!
            }
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var underlineActive: UIColor? {
        get {
            return self.underlineActive
        }
        set {
            if newValue != nil {
                self.delegate = self
                textFieldUnderlineActive[self] = newValue!
            }
        }
    }
    /// SwifterSwift: Border width of view; also inspectable from Storyboard.
    @IBInspectable public var autoReturn: Bool {
        get {
            return self.autoReturn
        }
        set {
            if newValue {
                self.delegate = self
                _ = self.textFieldShouldReturn(self)
            }
        }
    }
}
extension UITextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let activeUnderline = textFieldUnderlineActive[textField] else { return }
        textField.underlined(color: activeUnderline)
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let underline = textFieldUnderline[textField] else { return }
        textField.underlined(color: underline)
    }
}
extension UISearchBar {
    /// SwifterSwift:  width of view; also inspectable from Storyboard.
    @IBInspectable public var textColor: UIColor {
        get {
            return self.textColor
        }
        set {
            self.textField?.textColor = newValue
        }
    }
    private func getViewElement<T>(type: T.Type) -> T? {
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    func setTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    func setTextFieldColor(color: UIColor) {
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
                case .minimal:
                    textField.layer.backgroundColor = color.cgColor
                    textField.layer.cornerRadius = 6
                case .prominent, .default:
                    textField.backgroundColor = color
                @unknown default:
                    fatalError()
            }
        }
    }
    func setPlaceholderTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
}

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
