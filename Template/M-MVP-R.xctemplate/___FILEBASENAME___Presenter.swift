//___FILEHEADER___

import Foundation

// MARK: - ...  Presenter
class ___FILEBASENAME___: BasePresenter<___VARIABLE_moduleName___ViewContract> {
}
// MARK: - ...  Presenter Contract
extension ___FILEBASENAME___: ___FILEBASENAME___Contract {
}
// MARK: - ...  Example of network response
extension ___FILEBASENAME___ {
    func fetchResponse<T: ___VARIABLE_moduleName___Model>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
