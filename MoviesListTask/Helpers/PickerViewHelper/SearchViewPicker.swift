//
//  SearchViewPicker.swift
//  BaseIOS
//
//  Created by R.Soliman on 08/06/2021.

//

import UIKit

class SearchViewPicker: UIViewController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    @IBOutlet weak var sourceTbl: UITableView! {
        didSet {
            sourceTbl.delegate = self
            sourceTbl.dataSource = self
        }
    }
    weak var delegate: SearchViewPickerDelegate?
    var source: [Keyword] = []
    var searchSource: [Keyword] = []
    var didSelectClosure: PickerDidSelectPath?
    var didSelectItemClosure: PickerDidSelectItem?
    var selectedRow: IndexPath?
}


// MARK: - ...  Lifeycle
extension SearchViewPicker {
    override func viewDidLoad() {
        super.viewDidLoad()
        searchSource.append(contentsOf: source)
        sourceTbl.reloadData()
        sourceTbl.autoHeight()
    }
}

// MARK: - ...  actions
extension SearchViewPicker {
    @IBAction func okBtn(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            if (self?.source.count ?? 0) > 0 {
                guard let id = self?.selectedRow?.row else { return }
                guard let item = self?.source[id] else { return }
                self?.delegate?.searchViewPicker(self, didSelect: id)
                self?.delegate?.searchViewPicker(self, didSelect: item)
                self?.didSelectClosure?(id)
                self?.didSelectItemClosure?(item)
            }
        }
    }
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - ...  search Technic
extension SearchViewPicker {
    func reset() {
        searchSource.removeAll()
        searchSource.append(contentsOf: source)
        sourceTbl.reloadData()
    }
    func search(_ text: String?) {
        guard let text = text else { return }
        searchSource.removeAll()
        source.forEach { [weak self] (keyword) in
            if keyword.title?.lowercased().contains(text.lowercased()) ?? false {
                self?.searchSource.append(keyword)
            }
        }
        sourceTbl.reloadData()
    }
}


// MARK: - ...  table view delegation & data source
extension SearchViewPicker: UITableViewDelegate, UITableViewDataSource {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = searchSource[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
    }
}


// MARK: - ...  search bar delegation
extension SearchViewPicker: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("Search")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("did end search")
        makeSearch()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("begin search")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("did cancel")
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("did change")
        makeSearch()
    }
    func makeSearch() {
        guard let text = searchBar.text else { return reset() }
        if text.isEmpty {
            reset()
        } else {
            search(text)
        }
    }
}

