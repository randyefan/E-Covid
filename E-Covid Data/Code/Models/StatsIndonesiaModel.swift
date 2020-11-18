//
//  File.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 18/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation
import SwiftyJSON

class StatsIndonesiaModel {
    var totalSpesimen: Int
    var totalSpesimenNegatif: Int
    var positif: Int
    var meninggal: Int
    var sembuh: Int
    var dirawat: Int
    
    init(_ json: JSON) {
        totalSpesimen = json["data"]["total_spesimen"].intValue
        totalSpesimenNegatif = json["data"]["total_spesimen_negatif"].intValue
        positif = json["update"]["total"]["jumlah_positif"].intValue
        meninggal = json["update"]["total"]["jumlah_meninggal"].intValue
        sembuh = json["update"]["total"]["jumlah_sembuh"].intValue
        dirawat = json["update"]["total"]["jumlah_dirawat"].intValue
    }
}
