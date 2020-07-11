//
//  HistoryViewController.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//

import UIKit

class HistoryViewController : BaseViewController {
    @IBOutlet weak var historyTableview: UITableView!
    var items = [LyricModel]()
    
    override func viewDidLoad() {
        super .viewDidLoad()
        historyTableview.register(HistoryTableViewCell.nib, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        loadItems()
    }
    
    private func loadItems() {
        items = HistoryRecordManager.ReadHistorySearch()
        historyTableview.reloadData()
    }
    
    @IBAction func removeHistoryTapped(_ sender: Any) {
        HistoryRecordManager.RemoveHistoryList()
        loadItems()
    }
    
    fileprivate func routeToLyricDetail(item: LyricModel) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LyricViewController") as! LyricViewController
        vc.lyric = item
        present(vc, animated: true, completion: nil)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier) as! HistoryTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        routeToLyricDetail(item: item)
    }
}
