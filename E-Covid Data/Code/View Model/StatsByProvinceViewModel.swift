//
//  StatsByProvinceViewModel.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 18/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

struct StatsByProvinceViewModel {
    var networkManager = NetworkManager()
    
    private var lastUpdate = BehaviorRelay<String>(value: "")
    
    private let _stats = BehaviorRelay<[StatsByProvinceModel]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var statsByProvince: Driver<[StatsByProvinceModel]> {
        return _stats.asDriver()
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    init() {
        requestStats()
    }
    
    private func requestStats() {
        networkManager.getStatsByProvince { (response, error) in
            self._isFetching.accept(true)
            
            if error != nil {
                self._error.accept(error.map { $0.rawValue })
                self._isFetching.accept(false)
                return
            }
            
            var statsProvince: [StatsByProvinceModel] = []
            guard let data = response else { return }
            for object in data["list_data"].arrayValue {
                statsProvince.append(StatsByProvinceModel(object))
            }
            let date = data["last_date"].stringValue
            self.lastUpdate.accept(date)
            self._stats.accept(statsProvince)
        }
        
        self._isFetching.accept(false)
    }
    
    func getLastUpdateDate() -> String {
        let date = lastUpdate.value
        return date.getIndonesianDateFormat(date)
    }
    
    func numberOfStatsProvince() -> Int {
        return _stats.value.count
    }
    
    func prepareCellForDisplayHome(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardStatCovidViewCell", for: indexPath) as? CardStatTableViewCell {
            let stats = _stats.value
            cell.layoutSubviews()
            cell.setupCell(viewModel: stats[indexPath.row])
            return cell
        }
        fatalError()
    }
}
