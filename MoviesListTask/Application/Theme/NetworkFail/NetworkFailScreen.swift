//
//  CategoryStoresModel.swift
//  Mutsawiq
//
//  Created by R.Soliman on 11/8/20.

//

import Foundation
import UIKit

@IBDesignable
class NetworkFailScreen: UIView {
   
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
        updateView()
    }
    
    func initNib() {
        let bundle = Bundle(for: NetworkFailScreen.self)
        bundle.loadNibNamed("NetworkFailScreen", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }
    func updateView() {
        
    }
    @IBAction func tryAgain(_ sender: Any) {
        let scene = UIApplication.topViewController() as? BaseController
      
        scene?.viewDidLoad()
        scene?.viewWillAppear(false)
    }
}


