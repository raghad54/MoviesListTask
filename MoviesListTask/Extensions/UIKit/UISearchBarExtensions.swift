//
//  UISearchBarExtensions.swift
//  SwifterSwift
//
//  Copyright © 2016 SwifterSwift
//

import UIKit

#if !os(watchOS)
// MARK: - Properties
public extension UISearchBar {

	/// SwifterSwift: Text field inside search bar (if applicable).
    var textField: UITextField? {
		let subViews = subviews.flatMap { $0.subviews }
		guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
			return nil
		}
		return textField
	}

	/// SwifterSwift: Text with no spaces or new lines in beginning and end (if applicable).
    var trimmedText: String? {
		return text?.trimmingCharacters(in: .whitespacesAndNewlines)
	}

}

// MARK: - Methods
public extension UISearchBar {

	/// SwifterSwift: Clear text.
    func clear() {
		text = ""
	}

}

#endif
