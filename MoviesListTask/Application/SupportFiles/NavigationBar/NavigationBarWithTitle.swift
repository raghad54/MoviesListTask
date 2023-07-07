//
//  NaviagtionBarWithTitleAndActionMenu.swift
//  Created by Raghad Ali on 02/01/2022.

import Foundation
import UIKit
import SwiftUI


protocol NavigationBarWithTitleDelegate {
    func backAction()
}

class NavigationBarWithTitle: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var ActionButton: UIButton!
    
    var isDark: Bool?
    var delegate: NavigationBarWithTitleDelegate?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        setupNib()
        addAction()
        checkForDark()
//        self.titleLabel.adjustsFontSizeToFitWidth = true
//        self.titleLabel.minimumScaleFactor = 0.25
        self.backButton.setTitle("", for: .normal)
        self.backButton.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
        if Localizer.current == .arabic {
            backButton.transform = CGAffineTransform(rotationAngle: 180 * .pi / 180.0);
        }
        self.contentView.shadow()
        self.containerView.shadow()
        self.contentView.backgroundColor = .gray
        
    }
    
   
    func checkForDark() {
        if isDark ?? true {
         //   navigationView.backgroundColor = R.color.blackColor()
           // navigationView.navigationTitle.textColor = .white
           // navigationView.backButton.tintColor = .white
        } else {
          //  navigationView.backgroundColor = .white
        //    navigationView.navigationTitle.textColor = R.color.blackColor()
       //     navigationView.backButton.tintColor = R.color.blackColor()
        }
    }
    func bind(titleLabel: String, isMenuHidden: Bool?, actionButtonTintColor: UIColor?) {
        self.titleLabel.text = titleLabel
       
    }
  
    func addAction() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        delegate?.backAction()
    }
    
    
    func setupNib() {
     //   Bundle.main.loadNibNamed(R.nib.navi.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

extension UIView {
    func setGradientBackground(gradientView: UIView) {
        let colorTop = UIColor(red: 37/255.0, green: 222/255.0, blue: 186/255.0, alpha: 1.0).cgColor
        let colorBottom =  UIColor(red: 18/255.0, green: 167/255.0, blue: 138/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: gradientView.frame.size.width, height: gradientView.frame.size.height)
                
        gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



