//
//  CheckBo.swift

//
//  Created by R.Soliman on 03/06/2021.

//

import Foundation
import UIKit

class CheckBoxButton: UIButton {
    private var didSelect: () -> Void = { } {
        willSet {
        }
    }
    /// The closure that will be called when the control is deselected.
    private var didDeselect: () -> Void = { } {
        willSet {
        }
    }
    var isOn: Bool {
        didSet {
            if isOn {
                let image = #imageLiteral(resourceName: "check-box.pdf").withRenderingMode(.alwaysTemplate)
                tintColor = tintColor
                setBackgroundImage(image, for: .normal)
            } else {
                let image = #imageLiteral(resourceName: "blank-check-box.pdf").withRenderingMode(.alwaysTemplate)
                tintColor = tintColor
                setBackgroundImage(image, for: .normal)
            }
        }
    }
    
    // MARK: - Callbacks

    /// Sets a closure that will be called when the control is selected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    override func awakeFromNib() {
        super.awakeFromNib()
        isOn = false
    }

    // MARK: - Callbacks

    /// Sets a closure that will be called when the control is selected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    override init(frame: CGRect) {
        self.isOn = false
        super.init(frame: CGRect(x: frame.minX, y: frame.minY, width: 24, height: 24))
        addTarget(self, action: #selector(clickAction), for: .touchUpInside)
    }
    // MARK: - Callbacks

    /// Sets a closure that will be called when the control is selected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    required init?(coder: NSCoder) {
        self.isOn = false
        super.init(coder: coder)
        addTarget(self, action: #selector(clickAction), for: .touchUpInside)
    }

    
    // MARK: - Callbacks

    /// Sets a closure that will be called when the control is selected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    public func onSelect(execute closure: @escaping () -> Void) {
        didSelect = closure
    }

    /// Sets a closure that will be called when the control is deselected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    public func onDeselect(execute closure: @escaping () -> Void) {
        didDeselect = closure
    }
    // MARK: - Callbacks

    /// Sets a closure that will be called when the control is selected.
    ///
    /// - Important: Calling this will also add the required `UITapGestureRecognizer`, unless it was already added or
    //`useTapGestureRecognizer` was set to `false`.
    /// - Parameter closure: The closure the be called.
    @objc func clickAction() {
        //self.fadeOut()
        //self.fadeIn(duration: 0.5, completion: nil)
        isOn = !isOn
        if isOn {
            didSelect()
        } else {
            didDeselect()
        }
    }
}
