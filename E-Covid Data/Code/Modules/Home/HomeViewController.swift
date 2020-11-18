//
//  HomeViewController.swift
//  E-Covid Data
//
//  Created by Randy Efan Jayaputra on 17/11/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var positifLabel: UILabel!
    @IBOutlet weak var sembuhLabel: UILabel!
    @IBOutlet weak var meninggalLabel: UILabel!
    @IBOutlet weak var dirawatLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var viewLastUpdate: UIView! {
        didSet {
            viewLastUpdate.layer.cornerRadius = 20
        }
    }
    
    var statsViewModel = StatsByProvinceViewModel()
    var statsIndonesianViewModel = StatsIndonesianViewModel()
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerObserver()
    }
    
    func registerObserver() {
        statsViewModel.statsByProvince.drive(onNext: { [weak self] stats in
            if !stats.isEmpty {
                self?.setupTableView()
                self?.setupLastUpdate()
                self?.tableView.reloadData()
            } else {
                print("tunggu sebentar ya")
            }
        }).disposed(by: disposeBag)
        
        statsIndonesianViewModel.statsIndonesia.drive(onNext: { [weak self] statsIndonesia in
            self?.setupView(model: statsIndonesia)
            self?.setupCountTime()
        }).disposed(by: disposeBag)
    }
    
    func setupCountTime() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
    }
    
    func setupLastUpdate() {
        lastUpdateLabel.text = statsViewModel.getLastUpdateDate()
    }
    
    func setupView(model: StatsIndonesiaModel) {
        positifLabel.text = "\(model.positif.formattedWithSeparator)"
        sembuhLabel.text = "\(model.sembuh.formattedWithSeparator)"
        meninggalLabel.text = "\(model.meninggal.formattedWithSeparator)"
        dirawatLabel.text = "\(model.dirawat.formattedWithSeparator)"
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        tableView.register(UINib(nibName: "CardStatCovidViewCell", bundle: nil), forCellReuseIdentifier: "CardStatCovidViewCell")
    }
    
    @objc func countTime() {
        let currentDateTime = Date()
        let userCalendar = Calendar.current
        let requestedComponents: Set<Calendar.Component> = [
            .hour,
            .minute,
            .second
        ]
        
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        updateLabel(time: dateTimeComponents)
    }
    
    func updateLabel(time: DateComponents) {
        hourLabel.text = "\(time.hour!)"
        minuteLabel.text = "\(time.minute!)"
        secondsLabel.text = "\(time.second!)"
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsViewModel.numberOfStatsProvince()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return statsViewModel.prepareCellForDisplayHome(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.01 * Double(indexPath.row), animations: {
              cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        })
    }


}
