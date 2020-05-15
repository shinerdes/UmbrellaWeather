//
//  OpenSourceVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2020/04/16.
//  Copyright © 2020 김영석. All rights reserved.
//

import UIKit

var openSourceType = ""

class OpenSourceVC: UIViewController {

    @IBOutlet weak var colorView1: UIView!
    
    @IBOutlet weak var colorView2: UIView!
    @IBOutlet weak var colorView3: UIView!
    @IBOutlet weak var colorView4: UIView!
    @IBOutlet weak var colorView5: UIView!
    
    
    
    @IBOutlet weak var explainBtn1: UIButton!
    @IBOutlet weak var explainBtn2: UIButton!
    @IBOutlet weak var explainBtn3: UIButton!
    @IBOutlet weak var explainBtn4: UIButton!
    @IBOutlet weak var explainBtn5: UIButton!
    
    
    
   
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
        setState()
        
        
        explainBtn1.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        explainBtn2.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        explainBtn3.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        explainBtn4.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        explainBtn5.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView2.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView3.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView4.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView5.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
     
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goExplainBtnWasPressed(_ sender: Any) {
        
        openSourceType = "IGColorPicker"
        if let OpenSourceExplainVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceExplainVC"){
            
            
             self.present(OpenSourceExplainVC, animated: true, completion: nil)
                 
             }
        
      
    }
    
    
    @IBAction func goExplainBtnWasPressed2(_ sender: Any) {
        openSourceType = "GoogleMaps"
        if let OpenSourceExplainVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceExplainVC"){
               self.present(OpenSourceExplainVC, animated: true, completion: nil)
                   
            }
        
       
     
    }
    
    @IBAction func goExplainBtnWasPressed3(_ sender: Any) {
        openSourceType = "GooglePlaces"
              if let OpenSourceExplainVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceExplainVC"){
                     self.present(OpenSourceExplainVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func goExplainBtnWasPressed4(_ sender: Any) {
        openSourceType = "Alamofire"
              if let OpenSourceExplainVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceExplainVC"){
                     self.present(OpenSourceExplainVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func goExplainBtnWasPressed5(_ sender: Any) {
        openSourceType = "OpenWeatherAPI"
              if let OpenSourceExplainVC = self.storyboard?.instantiateViewController(withIdentifier: "openSourceExplainVC"){
                     self.present(OpenSourceExplainVC, animated: true, completion: nil)
        }
    }
    //openSourceExplainVC
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension OpenSourceVC {
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
            
            worldRed = 0
            worldGreen = 0
            worldBlue = 0
            worldRange = 6
          
            // default setting
            
            
        }
    }
}




