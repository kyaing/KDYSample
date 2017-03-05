//
//  ViewController.swift
//  Timeline
//
//  Created by mac on 17/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    public lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        tb.register(UINib(nibName: "TimelinesTableCell", bundle: nil), forCellReuseIdentifier: "TimelinesCell")
        tb.estimatedRowHeight = 300
        tb.rowHeight = UITableViewAutomaticDimension
        tb.tableFooterView = UIView()
        tb.dataSource = self
        tb.delegate = self
        
        self.view.addSubview(tb)
        
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Timelines"
        tableView.reloadData()
    }
}

// MARK: -
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelinesCell", for: indexPath) as! TimelinesTableCell
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.timeline.upColor = .clear
            cell.titleLabel.text = "2017-3-5"
            cell.contentLabel.text = "据新华社电 中国载人航天工程新闻发言人4日表示,天舟一号货运飞船将于4月中下旬在文昌航天发射场发射,并开展货物运输补给、推进剂在轨补加、自主快速交会对接等多项关键技术试验。这是中国载人航天工程空间实验室阶段的收官之战。"
        }
        
        if indexPath.row == 1 {
            cell.titleLabel.text = "2017-3-6"
            cell.contentLabel.text = "按计划,天舟一号发射入轨后,将与在轨运行的天宫二号先后进行3次自主快速交会对接、3次推进剂在轨补加,以及空间应用和航天技术等多领域的实(试)验项目。其间,天舟一号与天宫二号组合体在轨飞行约2个月,天舟一号独立飞行约3个月。完成既定任务后,天舟一号将受控离轨,陨落至预定安全海域;天宫二号留轨继续开展拓展试验和应用。"
        }
        
        if indexPath.row == 2 {
            cell.timeline.downColor = .clear
            cell.titleLabel.text = "2017-3-7"
            cell.contentLabel.text = "中国载人航天工程自1992年9月21日立项以来,25年间始终按“三步走”战略分步推动实施。当前,空间站研制建设各项工作正在稳步推进,后续将先后发射空间站核心舱和实验舱,计划2022年完成空间站的在轨组装建造。"
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

