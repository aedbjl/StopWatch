//
//  ViewController.swift
//  StopWatch
//
//  Created by iii-user on 2017/6/27.
//  Copyright © 2017年 iii-user. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource {

    
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var minuteLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var hsLabel: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var btnStartOrStop: UIButton!
    
    @IBOutlet weak var btnLapOrReset: UIButton!
    
    private var isStart = false
    private var laps:Array<String> = []
    private var timer:Timer?
    private var counter = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = laps[indexPath.row]
        return cell!
    }
    
    
    
    
    @IBAction func changeStartOrStop(_ sender: Any) {
        isStart = !isStart
        if isStart {
            //running
            btnStartOrStop.setTitle("stop", for: .normal)
            btnLapOrReset.setTitle("lap", for: .normal)
            doStart()
        }else {
            btnStartOrStop.setTitle("start", for: .normal)
            btnLapOrReset.setTitle("reset", for: .normal)
            doStop()
        }
    }
    
    @IBAction func doResetOrLap(_ sender: Any) {
        if isStart{
            doLap()
        }else{
            doReset()
        }
        
    }
    
    private func doStart(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
          self.counter += 1
          self.showCounter()
        })
    }
    
    private func showCounter(){
        hsLabel.text = String(counter % 100)
        let ts = counter / 100
        secondLabel.text = String(ts % 60)
        let tm = ts / 60
        minuteLabel.text = String(tm % 60)
        let th = tm / 60
        hourLabel.text = String(th % 60)
    }
    private func doStop(){
        timer?.invalidate()
        timer = nil
    }
    
    private func doReset(){
        counter = 0
        laps = []
        showCounter()
        tableview.reloadData()
    }
    
    private func doLap(){
       let lapString = hourLabel.text! + ":" + minuteLabel.text! + ":" +
        secondLabel.text! + ":" + hsLabel.text!
        laps += [lapString]
        tableview.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCounter()
    }

    

}

