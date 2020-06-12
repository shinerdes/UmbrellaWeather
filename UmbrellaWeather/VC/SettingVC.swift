//
//  SettingVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2019/12/20.
//  Copyright © 2019 김영석. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

 
    @IBOutlet weak var colorView1: UIView!
    
    @IBOutlet weak var goOpenSourceBtn: UIButton!
    @IBOutlet weak var goTimeRangeBtn: UIButton!
    @IBOutlet weak var goColorSettingBtn: UIButton!
    @IBOutlet weak var goAlertSetting: UIButton!
    
    @IBOutlet weak var colorView4: UIView!
    @IBOutlet weak var colorView5: UIView!
    @IBOutlet weak var colorView6: UIView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setState()
        
        backBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        backBtn.titleLabel!.numberOfLines = 1
        
        print("빨강 \(worldRed)")
        print("초록 \(worldGreen)")
        print("파랑 \(worldBlue)")
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized)
            {
                print("Push authorized")
               
            }
            else
            {
                print("Push not authorized")
                
            }
        }
        
        
        backBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
        print(UNUserNotificationCenter.self.current())
        print(UNUserNotificationCenter.current())
      
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView4.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView5.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView6.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        
        goOpenSourceBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        goTimeRangeBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        goColorSettingBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        goAlertSetting.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        // Do any additional setup after loading the view.
    }
    
    // 설정 1 : 우산 판정에 대한 시간 범위 : 12시간 15시간 18시간 21시간 24시간
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        backBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        backBtn.titleLabel!.numberOfLines = 1
        
        setState()
        
        backBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView4.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView5.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView6.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    

    @IBAction func goTimeRangeBtnWasPressed(_ sender: Any) {
        
        if let TimeRangeControlVC = self.storyboard?.instantiateViewController(withIdentifier: "timeRangeControlVC"){
             self.present(TimeRangeControlVC, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func goColorSettingBtnWasPressed(_ sender: Any) {
        if let ColorSettingVC = self.storyboard?.instantiateViewController(withIdentifier: "colorSettingVC"){
                  self.present(ColorSettingVC, animated: true, completion: nil)
                 
             }
        
    }
    
    @IBAction func goAlertSettingBtnWasPressed(_ sender: Any) {
        
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized)
            {
                
                DispatchQueue.main.async {
                    print("Push authorized")
                    if let AlertSettingVC = self.storyboard?.instantiateViewController(withIdentifier: "alertSettingVC"){
                        self.present(AlertSettingVC, animated: true, completion: nil)
                    }
                }
                
            }
            else
            {
                print("Push not authorized")
                
                DispatchQueue.main.async {
                    let dialog = UIAlertController(title: "알림 미설정", message: "알림 허용을 설정하세요", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default){ (action: UIAlertAction) -> Void in
                        
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.openURL(url)
                        }
                        
                        
                        //self.dismiss(animated: true, completion: nil)
                    }
                    
                    
                    dialog.addAction(action)
                    
                    self.present(dialog, animated: true, completion: nil)
                    
                    
                    
                    
                    
                }
                //                if let url = URL(string: UIApplication.openSettingsURLString) {
                //                    UIApplication.shared.openURL(url)
                //                }
            }
        }
        
        
        
        // usernotification의 유무로 간다
        //
        
    }
    
    
    @IBAction func goOpenSourceBtnWasPressed(_ sender: Any) {
        if let OpenSourceVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceVC"){
        self.present(OpenSourceVC, animated: true, completion: nil)
            
        }
        
    }
   
}
extension SettingVC {
    func setState() {
        let userDefaults = UserDefaults.standard // 이게 값을 불러오는건데 애매하다. // default가 없으니깐 문제
        if let red = userDefaults.value(forKey: Setting.RGB.red.rawValue),
            let green = userDefaults.value(forKey: Setting.RGB.green.rawValue),
            let blue = userDefaults.value(forKey: Setting.RGB.blue.rawValue),
            let range = userDefaults.value(forKey: Setting.TIME.range.rawValue)
        {
            
            worldRed = red as! Int
            worldGreen = green as! Int
            worldBlue = blue as! Int
            worldRange = range as! Int
          
            
        } else {
            
            worldRed = 255
            worldGreen = 255
            worldBlue = 255
            worldRange = 6
          
            // default setting
            
            
        }
    }
}
