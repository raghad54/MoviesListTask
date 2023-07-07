//
//  NavigationBar.swift
//  BaseIOS
//
//  Created by Raghad Ali on 06/07/2023.
//

import Foundation
import UIKit


protocol NavigationBarDelegate {
    func backAction()
}

class NavigationBar: UIView {
    
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
    func bind(titleLabel: String, isBackHidden: Bool?) {
        self.titleLabel.text = titleLabel
        self.backButton.isHidden = isBackHidden ?? false
    }
  
    func addAction() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc func backButtonTapped() {
        delegate?.backAction()
    }
    
    
    func setupNib() {
        Bundle.main.loadNibNamed(R.nib.navigationBar.name, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = .systemBrown
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
