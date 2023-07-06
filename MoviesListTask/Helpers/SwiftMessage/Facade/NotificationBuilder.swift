//
//  SwiftMessageNotifyModel.swift
//  BaseIOS
//
//  Created by R.Soliman on 03/06/2021.

//

import Foundation

class NotificationBuilder: SwiftMessageFacade {
    var title: String? = "ERROR".localized,
        body: String? = nil,
        theme: Theme = .error,
        duration: SwiftMessages.Duration = .automatic,
        notifyStyle: SwiftMessages.PresentationStyle = .top,
        dimMode: SwiftMessages.DimMode? = nil,
        displayButton: Bool = false,
        agreeHandler: (() -> Void)? = nil
    
    init() {
        
    }
    func setTitle(_ title: String?) -> Self {
        self.title = title
        return self
    }
    func setBody(_ body: String?) -> Self {
        self.body = body
        return self
    }
    func setTheme(_ theme: Theme) -> Self {
        self.theme = theme
        return self
    }
    func setStyle(_ style: SwiftMessages.PresentationStyle) -> Self {
        self.notifyStyle = style
        return self
    }
    func setDuration(_ duration: SwiftMessages.Duration) -> Self {
        self.duration = duration
        return self
    }
    func setDimMode(_ dimMode: SwiftMessages.DimMode) -> Self {
        self.dimMode = dimMode
        return self
    }
    func setButton(_ button: Bool) -> Self {
        self.displayButton = button
        return self
    }
    func setAgreeHandler(_ handler: (() -> Void)?) -> Self {
        self.agreeHandler = handler
        return self
    }
    @discardableResult
    func bulid() -> Self {
        notify()
        return self
    }
}
