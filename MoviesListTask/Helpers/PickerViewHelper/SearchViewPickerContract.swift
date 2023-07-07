//
//  PickerSearchViewContract.swift

//
//  Created by R.Soliman on 08/06/2021.

//

import Foundation


// MARK: - ...  Keyword protocol must every source implement this keyword
protocol Keyword {
    var title: String? { get set }
}

// MARK: - ...  SearchViewPicker delegate
protocol SearchViewPickerDelegate: AnyObject {
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Int)
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Keyword)
}
extension SearchViewPickerDelegate {
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Int) { }
    func searchViewPicker(_ searchViewPicker: SearchViewPicker?, didSelect item: Keyword) { }
}

typealias PickerDidSelectPath = (Int) -> Void
typealias PickerDidSelectItem = (Keyword) -> Void
