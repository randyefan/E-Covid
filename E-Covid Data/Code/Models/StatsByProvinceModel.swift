//
//  StatsByProvinceModel.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 17/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation
import SwiftyJSON

class StatsByProvinceModel {
    var daerah: String
    var jumlahKasus: Int
    var jumlahSembuh: Int
    var jumlahMeninggal: Int
    var jumlahDirawat: Int
    var penambahanPositif: Int
    var penambahanSembuh: Int
    var penambahanMeninggal: Int
    
    init(_ json: JSON) {
        daerah = json["key"].stringValue
        jumlahKasus = json["jumlah_kasus"].intValue
        jumlahSembuh = json["jumlah_sembuh"].intValue
        jumlahMeninggal = json["jumlah_meninggal"].intValue
        jumlahDirawat = json["jumlah_dirawat"].intValue
        penambahanPositif = json["penambahan"]["positif"].intValue
        penambahanSembuh = json["penambahan"]["sembuh"].intValue
        penambahanMeninggal = json["penambahan"]["meninggal"].intValue
    }
}
