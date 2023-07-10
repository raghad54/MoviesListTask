//
//  NavigationBar.swift

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
    
    var isDark: Bool?
    var delegate: NavigationBarDelegate?
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
        self.backButton.setTitle("", for: .normal)
        self.backButton.setImage(UIImage(named: "back_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
        self.contentView.shadow()
        self.containerView.shadow()
    }

    func bind(titleLabel: String, isBackHidden: Bool?) {
        self.titleLabel.text = titleLabel
        self.titleLabel.textAlignment = .center
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
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
