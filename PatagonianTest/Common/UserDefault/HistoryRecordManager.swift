//
//  HistoryRecordManager.swift
//  PatagonianTest
//
//  Created by David Diego Gomez on 11/07/2020.
//  Copyright © 2020 David Diego Gomez. All rights reserved.
//
import UIKit

class HistoryRecordManager {
    let shared : HistoryRecordManager!
    
    init() {
        shared = HistoryRecordManager()
    }
    
    var lyricArray = [LyricModel]()
    
    enum Keys : String {
        case historySearch = "historySearch"
    }
    
    static func SaveHistorySearch(items: [LyricModel]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: Keys.historySearch.rawValue)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func ReadHistorySearch() -> [LyricModel] {
       
        if let data = UserDefaults.standard.object(forKey: Keys.historySearch.rawValue) as? Data {
            do {
                let item = try JSONDecoder().decode([LyricModel].self, from: data)
                return item
            } catch {
                return [LyricModel]()
            }
        }
        
        return [LyricModel]()
    }
    
    static func RemoveHistoryList() {
        UserDefaults.standard.set(nil, forKey: Keys.historySearch.rawValue)
    }
    
}


