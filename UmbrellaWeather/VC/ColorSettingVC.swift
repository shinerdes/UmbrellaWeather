//
//  ColorSettingVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2020/01/10.
//  Copyright © 2020 김영석. All rights reserved.
//

import UIKit
import IGColorPicker

class ColorSettingVC: UIViewController, ColorPickerViewDelegate, ColorPickerViewDelegateFlowLayout {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var colorPickerView: ColorPickerView!
    @IBOutlet weak var selectedColorView: UIView!
    @IBOutlet weak var aroundSelectColorView: UIView!
   
    var pickerRed = 0
    var pickerGreen = 0
    var pickerBlue = 0
    
 
    @IBOutlet weak var colorView1: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setState()
        
        aroundSelectColorView.layer.borderColor = UIColor.black.cgColor
        aroundSelectColorView.layer.borderWidth = 2.0
        colorPickerView.layer.borderColor = UIColor.black.cgColor
        colorPickerView.layer.borderWidth = 2.0


        
        colorPickerView.delegate = self
        colorPickerView.layoutDelegate = self
        colorPickerView.selectionStyle = .check
        colorPickerView.isSelectedColorTappable = false
        colorPickerView.style = .square
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setState()
        
        saveBtn.isEnabled = false
        
        backBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
      
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("되나")
        
    }
    
    
    
    
    
    // out으로 나오는 color에 대한 rgb값을 내놔야 한다
    
    
    func colorPickerView(_ colorPickerView: ColorPickerView, didSelectItemAt indexPath: IndexPath) {
        self.selectedColorView.backgroundColor = colorPickerView.colors[indexPath.item]
        
        pickerRed = Int(colorPickerView.colors[indexPath.item].cgColor.components![0]*255)
        pickerGreen = Int(colorPickerView.colors[indexPath.item].cgColor.components![1]*255)
        pickerBlue = Int(colorPickerView.colors[indexPath.item].cgColor.components![2]*255)
        // 단지 print일뿐 저장은 다른 문제긴 함
        saveBtn.isEnabled = true
    
        
        // 이걸 GLOBAL로 깔고 가면 된다.
        
        
    }
    
    
    
    func colorPickerView(_ colorPickerView: ColorPickerView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func colorPickerView(_ colorPickerView: ColorPickerView, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    
    
    
    @IBAction func savePickerColor(_ sender: Any) {
        
        // 미 선택시 BUTTON이 비활성화 상태로 가게 되어야 할듯?
        
        UserDefaults.standard.set(pickerRed, forKey: Setting.RGB.red.rawValue)
        UserDefaults.standard.set(pickerGreen, forKey: Setting.RGB.green.rawValue)
        UserDefaults.standard.set(pickerBlue, forKey: Setting.RGB.blue.rawValue)
        
        
        setState()
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
   
        // Alpha값으로 투명도 차이줘서 ui에서 구분 가능하게만 해주면 될듯 ?
        
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension ColorSettingVC {
    func setState() {
        let userDefaults = UserDefaults.standard
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
