//
//  TimeRangeControlVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2020/01/15.
//  Copyright © 2020 김영석. All rights reserved.
//

import UIKit

class TimeRangeControlVC: UIViewController {
    
    
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var rangeLbl: UILabel!
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rangeLbl.text = "\(worldRange*3) Hour"
        
        
        backBtn.layer.masksToBounds = true
        rangeLbl.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
      
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    // save 버튼이 아닌 변경시 바로 적용되는걸로
    @IBAction func prevBtnWasPressed(_ sender: Any) {
        if worldRange > 4 {
            worldRange = worldRange - 1
            rangeLbl.text = "\(worldRange*3) Hour"
            UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
            // 값 줄여주고 바로 userDefault
            
        } else {
            print("이미 최소값이다")
        }
    }
    
    
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if worldRange < 8 {
            worldRange = worldRange + 1
            rangeLbl.text = "\(worldRange*3) Hour"
            UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)

        } else {
            print("이미 최대값이다")
        }
    }
   
}
 // load & save 둘다 가야함


extension TimeRangeControlVC {
    func setUp() {
        let userDefaults = UserDefaults.standard // 이게 값을 불러오는건데 애매하다. // default가 없으니깐 문제
        if let range = userDefaults.value(forKey: Setting.TIME.range.rawValue) {
            worldRange = range as! Int
        } else {
            
        }
 
    }
    
}
