//
//  ViewController.swift
//  NoData
//
//  Created by Tran Ngoc Nam on 3/28/18.
//  Copyright © 2018 Tran Ngoc Nam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    var dataNumber = DataSourceNumber()
    var dataString = DataSourceString()
    
    // White View
    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    // Check No Data
    var hasNoData: Bool = false {
        didSet {
            tableView.tableFooterView = hasNoData ? noDataView : footerView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = dataNumber
        
        dataNumber.viewController = self
        dataString.viewController = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (dataNumber.numbers.count == 0) && (dataString.strings.count == 0){
            tableView.tableFooterView = noDataView
        } else {
            tableView.tableFooterView = footerView
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func switchButtom(_ sender: UISwitch) {
        tableView.dataSource = sender.isOn ? dataNumber : dataString
        hasNoData = sender.isOn ?  (dataNumber.numbers.count == 0) : (dataString.strings.count == 0)
        tableView.reloadData()
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        guard let newData = (unwindSegue.source as? DetailViewController)?.detailData else { return }
        let selected = btnSwitch.isOn ? dataNumber.numbers.count : dataString.strings.count
        let indexPath = IndexPath(row: selected, section: 0)
        if btnSwitch.isOn == true {
            dataNumber.numbers.append(Int(newData) ?? 0)
        } else {
            dataString.strings.append(newData)
        }
        //tableView.reloadData()
        tableView.insertRows(at: [indexPath], with: .automatic)
        hasNoData = btnSwitch.isOn ?  (dataNumber.numbers.count == 0) : (dataString.strings.count == 0)
    }
}

