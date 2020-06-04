//
//  AlertSettingVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2020/02/02.
//  Copyright © 2020 김영석. All rights reserved.
//

import UIKit
import UserNotifications

class AlertSettingVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // pickerview infi scroll
    // 저장하게 되면 다시 로드 했을떄 default값으로
    
    var enterMainVC : MainVC = MainVC()
    
    
    var datePickerData: [[String]] = [[String]]()
    
    var selectAmPm = "AM"
    var selectHour = ""
    var selectMinute = ""
    
    
    @IBOutlet weak var alertSaveBtn: UIButton!
    @IBOutlet weak var datePickerView: UIPickerView! // AM:12:00 부터 시작
    @IBOutlet weak var saveSwitch: UISwitch! // 이거는 userdefault 기준으로 가야함
    
    
    @IBOutlet weak var amPmLbl: UILabel!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var minuteLbl: UILabel!
    
  
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView4: UIView!
    
    
    @IBOutlet weak var alertOnOffLbl: UILabel!

    @IBOutlet weak var resetBtn: UIButton!
    
    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertSaveBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        alertSaveBtn.titleLabel!.numberOfLines = 1
        
        backBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        backBtn.titleLabel!.numberOfLines = 1
     
        saveSwitch.isOn = worldAlertSwitch
        amPmLbl.text = worldTwelveHour
        hourLbl.text = ("\(worldHour)")
        minuteLbl.text = ("\(worldMinute)")
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView4.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        //setState()
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        
        setState()
        
        
       
        
        
        datePickerView.setValue(UIColor.white, forKeyPath: "textColor")
        resetBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        selectAmPm = worldTwelveHour
        selectHour = "\(worldHour)"
        selectMinute = "\(worldMinute)"
        
        
        backBtn.layer.masksToBounds = true
        saveBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
        print("\(worldRed)")
        print("\(worldGreen)")
        print("\(worldBlue)")
        
    
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { (didAllow, error) in
        })
        UNUserNotificationCenter.current().delegate = self
            
        self.datePickerView.delegate = self
        self.datePickerView.dataSource = self

        datePickerData = [["AM", "PM"],
        ["12","1","2","3","4","5","6","7","8","9","10","11"],
        ["0","1","2","3","4","5","6","7","8","9","10",
            "11","12","13","14","15","16","17","18","19","20",
            "21","22","23","24","25","26","27","28","29","30",
            "31","32","33","34","35","36","37","38","39","40",
            "41","42","43","44","45","46","47","48","49","50",
            "51","52","53","54","55","56","57","58","59"]]
    
        
        if saveSwitch.isOn == false {
            alertSaveBtn.isEnabled = false
        } else if saveSwitch.isOn == true {
            alertSaveBtn.isEnabled = true
        }
        // Do any additional setState after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        alertSaveBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        alertSaveBtn.titleLabel!.numberOfLines = 1
        
        backBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        backBtn.titleLabel!.numberOfLines = 1
        
        
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        saveSwitch.isOn = worldAlertSwitch
        amPmLbl.text = worldTwelveHour
        hourLbl.text = ("\(worldHour)")
        minuteLbl.text = ("\(worldMinute)")
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView4.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        //setState()
        setState()
        
        
        print("\(worldRed)")
        print("\(worldGreen)")
        print("\(worldBlue)")
        
        
      
        
        datePickerView.setValue(UIColor.white, forKeyPath: "textColor")
        resetBtn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        
        selectAmPm = worldTwelveHour
        selectHour = "\(worldHour)"
        selectMinute = "\(worldMinute)"
        
        
        backBtn.layer.masksToBounds = true
        saveBtn.layer.masksToBounds = true
        titleLbl.layer.masksToBounds = true
        
    
        
        
        if saveSwitch.isOn == false {
            alertSaveBtn.isEnabled = false
        } else if saveSwitch.isOn == true {
            alertSaveBtn.isEnabled = true
        }
        
        print("우리는 load를 했다 \(worldTwelveHour) \(worldHour) \(worldMinute)")
        
        amPmLbl.text = "\(worldTwelveHour)"
        hourLbl.text = "\(worldHour)"
        minuteLbl.text = "\(worldMinute)"
        
      
        
        // 여기서 초기 pickerview 설정해야할듯
        
        //1. ampm
        if worldTwelveHour == "AM" {
            datePickerView.selectRow(0, inComponent: 0, animated: true) //
        } else {
            datePickerView.selectRow(1, inComponent: 0, animated: true)
        }
        
        if worldHour == 12 {
            datePickerView.selectRow(0, inComponent: 1, animated: true)
        } else {
            datePickerView.selectRow(worldHour, inComponent: 1, animated: true)
        }
        
        datePickerView.selectRow(worldMinute, inComponent: 2, animated: true)

        //2. hour
        
        //3. minute
        
        //datePickerView.selectRow(3, inComponent: 2, animated: true) // 0~ 세로  , 0~ 가로

        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func resetBtnWasPressed(_ sender: Any) {
        
        
        
        if worldTwelveHour == "AM" {
            datePickerView.selectRow(0, inComponent: 0, animated: true) //
        } else {
            datePickerView.selectRow(1, inComponent: 0, animated: true)
        }
        
        if worldHour == 12 {
            datePickerView.selectRow(0, inComponent: 1, animated: true)
        } else {
            datePickerView.selectRow(worldHour, inComponent: 1, animated: true)
        }
        
        datePickerView.selectRow(worldMinute, inComponent: 2, animated: true)
        
        selectAmPm = "AM"
        selectHour = "0"
        selectMinute = "0"
        
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        UserDefaults.standard.set(selectAmPm, forKey: Setting.Alert.twelvehour.rawValue)
        UserDefaults.standard.set(Int(selectHour), forKey: Setting.Alert.hour.rawValue)
        UserDefaults.standard.set(Int(selectMinute), forKey: Setting.Alert.minute.rawValue)
        
        
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        UserDefaults.standard.set(selectAmPm, forKey: Setting.Alert.twelvehour.rawValue)
        UserDefaults.standard.set(Int(selectHour), forKey: Setting.Alert.hour.rawValue)
        UserDefaults.standard.set(Int(selectMinute), forKey: Setting.Alert.minute.rawValue)
        
        
        setState()
        
        
        // 다 설정 해줘야함
        amPmLbl.text = "\(worldTwelveHour)"
        hourLbl.text = "\(worldHour)"
        minuteLbl.text = "\(worldMinute)"
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return datePickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return datePickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("셋업 \(datePickerData[component][row])")
        print("셋업 \(component)")
        print("셋업 \(row)")
        
        if component == 0 {
            selectAmPm = datePickerData[component][row]
        }
        
        else if component == 1 {
            selectHour = datePickerData[component][row]
        }
        
        else if component == 2 {
            
            selectMinute = datePickerData[component][row]
        }
        
    }
    


    @IBAction func alertSaveBtnWasPressed(_ sender: Any) {
        print(selectAmPm)
        print(selectHour)
        print(selectMinute)

        // 여기서 스위치가 켜 있는 상태여야 알림이 제대로 들어감.
        // 아예 button을 비활성화 하는 방법도 있음
        // 일단 맨처음엔 스위치는 off 되어있는 상태로 시작해야하고
        // 경우의 수
        
        // 일정 저장하면 월드에 저장은 될 수 있게 함
        // 만약에 저장을 안한다면? -> 그냥 그런거 없다
        // 저장엔 가능 + 이제 스위치도 생각해봐야하는데
        
        
        // 1. 스위치를 킴 -> 설정 -> 스위치를 끔 -> 알람 작동 안함 -> 근데 스위치만 끈 상태지 [picker에서 시간은 남아있어야]
        
        // 2. 스위치를 끈 상태서 -> 설정 -> 안되게 해야함 -> [버튼 비활성화] <ok>
        
        // 3. 스위치를 킴 -> 설정 -> 끔 -> 다시 킴 -> 시간 그대로 ( 다시 활성화는 안되게 하는게 나을듯 )
        
        // 4. 이게 알람 저장을 하는건 save 버튼만이 오직 유일하게 가능하다고 해야할듯?
        
        // 5. 일단 한번 저장을 했으면 world로 해당하는 시간대를 저장을 한번 해놓고
              // 다시 view가 떴을떄 picker에서 바로 보여지게 해야할듯?
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        UserDefaults.standard.set(selectAmPm, forKey: Setting.Alert.twelvehour.rawValue)
        UserDefaults.standard.set(Int(selectHour), forKey: Setting.Alert.hour.rawValue)
        UserDefaults.standard.set(Int(selectMinute), forKey: Setting.Alert.minute.rawValue)
        UserDefaults.standard.synchronize()
        
        UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
        UserDefaults.standard.set(worldRange, forKey: Setting.TIME.range.rawValue)
        UserDefaults.standard.set(selectAmPm, forKey: Setting.Alert.twelvehour.rawValue)
        UserDefaults.standard.set(Int(selectHour), forKey: Setting.Alert.hour.rawValue)
        UserDefaults.standard.set(Int(selectMinute), forKey: Setting.Alert.minute.rawValue)
        setState()

        print("save 눌렀을떄 setstats하고 ")
        print(worldTwelveHour)
         print(worldHour)
         print(worldMinute)
        print(worldAlertSwitch)
        
        amPmLbl.text = "\(worldTwelveHour)"
        hourLbl.text = "\(worldHour)"
        minuteLbl.text = "\(worldMinute)"
        
        
        
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                DispatchQueue.main.async {
                    
                    let nContent = UNMutableNotificationContent()
                    nContent.title = "우산을 가져가야하는지 확인하세요"
                    nContent.body = "\(self.selectAmPm) \(self.selectHour) \(self.selectMinute)"
                    
                    
                    // 이 데이터를 바로 불러오게 해야한다.
                    //nContent.title = "\(self.selectAmPm) \(self.selectHour) \(self.selectMinute)"
                    
                    // 백그라운드에서 잘 굴러감. 우산 소지에 대한 정보도 그냥 끌어올리면 가능할듯 ?
                    
                    nContent.sound = UNNotificationSound.default
                    
                    
                    let calendar = Calendar.current
                    var dateComponents = DateComponents()
                    
                    if self.selectAmPm == "AM" {
                        
                        if self.selectHour == "12" {
                            dateComponents.hour = 0
                        } else {
                            dateComponents.hour = Int(self.selectHour)!
                        }
                        
                        dateComponents.minute = Int(self.selectMinute)
                    }
                    else if self.selectAmPm == "PM" {
                        
                        
                        if self.selectHour == "12" {
                            dateComponents.hour = 12
                        } else {
                            dateComponents.hour = Int(self.selectHour)! + 12
                        }
                        
                        dateComponents.minute = Int(self.selectMinute)
                    }
                    
                    
                   let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    
                   let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                     
                    UNUserNotificationCenter.current().add(request) { (_) in
                        DispatchQueue.main.async {
                            
                            let date = "\(self.selectAmPm) \(self.selectHour) : \(self.selectMinute)"
                            let message = "알림이 등록되었습니다. 등록된 알림은 \(date)에 발송됩니다"
                            let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                            let ok = UIAlertAction(title: "확인", style: .default)
                            alert.addAction(ok)
                            self.present(alert, animated: false)
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되어 있지 않습니다", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
                
            }
        }
        
    }
    
    @IBAction func saveSwitchAction(_ sender: Any) {
        
        
        if saveSwitch.isOn == false { // switch off
            UserDefaults.standard.set(false, forKey: Setting.Alert.reservation.rawValue)
            setState()
            print("스위치 끔")
            print(worldAlertSwitch)
            // 스위치를 끄면 일단 알람은 stop으로 가게
            
            //UIApplication.shared.unregisterForRemoteNotifications()
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            print(UNUserNotificationCenter.current().removeAllPendingNotificationRequests())
            
            alertSaveBtn.isEnabled = false // save 버튼 shutdown
        }
            
        else if saveSwitch.isOn == true { // switch on
            
            UserDefaults.standard.set(true, forKey: Setting.Alert.reservation.rawValue)
            print("스위치 켬")
            setState()
             print(worldAlertSwitch)
            
            alertSaveBtn.isEnabled = true
            
            // 여기서 알람을 정상화 시켜야 함 
            //UIApplication.shared.registerForRemoteNotifications()
            //
            // 스위치를 키면 기존에 설정해놓은 시간대로 알람 적용이 다 되야함
            
            
            
          
        }
        
        
     
    }
    
    
    
   
    
}


extension AlertSettingVC : UNUserNotificationCenterDelegate {
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert, .sound, .badge])
     }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
        
    }
}

extension AlertSettingVC {
    func setState() {
        let userDefaults = UserDefaults.standard // 이게 값을 불러오는건데 애매하다. // default가 없으니깐 문제
        if let reservation = userDefaults.value(forKey: Setting.Alert.reservation.rawValue),
            let twelveHour = userDefaults.value(forKey: Setting.Alert.twelvehour.rawValue),
            let hour = userDefaults.value(forKey: Setting.Alert.hour.rawValue),
            let minute = userDefaults.value(forKey: Setting.Alert.minute.rawValue),
            let red = userDefaults.value(forKey: Setting.RGB.red.rawValue),
            let green = userDefaults.value(forKey: Setting.RGB.green.rawValue),
            let blue = userDefaults.value(forKey: Setting.RGB.blue.rawValue),
            let range = userDefaults.value(forKey: Setting.TIME.range.rawValue),
            let test = userDefaults.value(forKey: Setting.RGB.colorCheck.rawValue)
       
        {
            
            
            worldAlertSwitch = reservation as! Bool
            //saveSwitch.isOn = worldAlertSwitch
            
            worldTwelveHour = twelveHour as! String
            worldHour = hour as! Int
            worldMinute = minute as! Int
            
            worldRed = red as! Int
            worldGreen = green as! Int
            worldBlue = blue as! Int
            worldRange = range as! Int
            
            worldColorCheck = test as! Int
            
        } else {
            worldAlertSwitch = false
            worldTwelveHour = "AM"
            worldHour = 0
            worldMinute = 0
            
            worldRed = 255
            worldGreen = 255
            worldBlue = 255
            worldRange = 6
            
            worldColorCheck = 0
            // 아니 근데 없을 수가 없는데?
            // false <-> true
        }
        
    }
}

