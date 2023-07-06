import UIKit

extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
    static func topMostController() -> UIViewController {
        guard var topController: UIViewController = UIApplication.keyWindow?.rootViewController else { return UIViewController() }
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension UIApplication {
    static var keyWindow: UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return window
    }
}
