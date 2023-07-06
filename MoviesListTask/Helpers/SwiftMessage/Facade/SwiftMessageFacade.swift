//
//  SwiftMessageContract.swift
//  BookistaProvider
//
//  Created by R.Soliman on 21/04/2021.

//

import Foundation
import UIKit

protocol SwiftMessageFacade {
    
}

extension SwiftMessageFacade where Self: NotificationBuilder {
    
    func notify() {
        let view: MessageView
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: self.title, body: self.body, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide".localized, buttonTapHandler: { _ in
            SwiftMessages.hide()
            self.agreeHandler?()
        })

        let iconStyle: IconStyle
        iconStyle = .light
        view.configureTheme(self.theme, iconStyle: iconStyle)
        //view.configureDropShadow()
        if !self.displayButton {
            view.button?.isHidden = true
        }
        view.button?.setTitle("AGREE".localized, for: .normal)
        view.iconImageView?.isHidden = false
        view.iconLabel?.isHidden = false
        view.titleLabel?.isHidden = false
        view.bodyLabel?.isHidden = false
       
        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        config.presentationStyle = self.notifyStyle
        config.duration = self.duration
        if self.dimMode == nil {
            config.dimMode = .blur(style: .dark, alpha: 0.5, interactive: true)
        } else {
            config.dimMode = self.dimMode ?? .none
        }
        config.dimMode = .none
        SwiftMessages.show(config: config, view: view)
    }
}
