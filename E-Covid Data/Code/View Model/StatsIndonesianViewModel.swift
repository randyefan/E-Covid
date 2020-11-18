//
//  StatsIndonesianViewModel.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 17/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

struct StatsIndonesianViewModel {
    var networkManager = NetworkManager()
    
    private let _statsIndonesia = BehaviorRelay<StatsIndonesiaModel>(value: StatsIndonesiaModel(""))
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var statsIndonesia: Driver<StatsIndonesiaModel> {
        return _statsIndonesia.asDriver()
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    init() {
        requestStatsIndo()
    }
    
    private func requestStatsIndo() {
        networkManager.getStatsIndonesian { (response, error) in
            self._isFetching.accept(true)
            
            if error != nil {
                self._error.accept(error.map {$0.rawValue})
                self._isFetching.accept(false)
            }
            
            guard let data = response else { return }
            self._statsIndonesia.accept(StatsIndonesiaModel(data))
        }
        
        self._isFetching.accept(false)
    }
    
    
}
