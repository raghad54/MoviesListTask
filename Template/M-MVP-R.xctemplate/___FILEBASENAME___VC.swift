//___FILEHEADER___

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ___FILEBASENAME___: BaseController {
    var presenter: ___VARIABLE_moduleName___Presenter?
    var router: ___VARIABLE_moduleName___Router?
}

// MARK: - ...  LifeCycle
extension ___FILEBASENAME___ {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ___FILEBASENAME___ {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension ___FILEBASENAME___: ___VARIABLE_moduleName___ViewContract {
}
