//
//  MainVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2019/12/10.
//  Copyright © 2019 김영석. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import GooglePlaces
import GoogleMaps
import UserNotifications

//지역, 날씨, 온도, 비, 눈, 우산판정 등 데이터 뽑아내기

//시간은 현재 시간으로 깨야할듯?

// 만약 38에서 설정 값이 바뀌어서 한계가 36이면 이건 오류가 나니깐 조정을 해줘야 한다고 봄
// 리셋을 해주거나 뭐 해줘야할듯?
// 설정으로 가면 아예 보여주는건 리셋으로 하자

var rangeIndex = 6 // 4 5 6 7 8 // 12시간 ~ 24시간

// RBG값, rangeIndex 값이 해당 된다. + 색상부분이나 다른부분은 추가된다.
// 이제 데이터는 유저 데이터로 항시 저장으로 간다. userdefaults 사용

struct Setting{
    enum RGB:String{
        case red
        case green
        case blue
        case colorCheck
    }
    
    enum TIME:String {
        case range
    }
    
    enum Alert:String {
        case reservation
        case twelvehour
        case hour
        case minute
    }
    
}
// 전체 범위로 도는 변수들

var worldRed: Int = 0 // 빨강
var worldGreen: Int = 0 // 초록
var worldBlue: Int = 0 // 파랑

var worldColorCheck: Int = 0

var worldRange: Int = 6 // 시간범위
var worldAlertSwitch: Bool = true // 알람 스위치


var worldTwelveHour = "AM" // 알람용 AM/PM
var worldHour = 0 // 알람용 시
var worldMinute = 0 // 알람용 분







class MainVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var nowRainLbl: UILabel!
    @IBOutlet weak var snowLbl: UILabel!
    @IBOutlet weak var umbrellaLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    
    @IBOutlet weak var beforeBtn: UIButton!
    @IBOutlet weak var afterBtn: UIButton!
    
    
    @IBOutlet weak var colorView1: UIView!
    @IBOutlet weak var colorView2: UIView!
    
   
    @IBOutlet weak var iconImageView: UIImageView!
    
  
    
    
    let APIKEY = "5eef6dde7344d983f06aaa5752d0a1ed"
    let BASEURL = "https://api.openweathermap.org/data/2.5/" // 변경
    let WEATHER = "forecast?" // 변경
    var lat = 0.0 // 위도
    var lng = 0.0 // 경도
    var timeLine = 0
    var units = "metric"
    var unit = "C"
    var locationManager = CLLocationManager()
    var imsiCount = 0 // 보여줄 시간의 기준. 0~(40-range)
    var highRainGrade = 0
    var highSnowGrade = 0
    
    
    
    @IBOutlet weak var worldRangeLbl: UILabel!
    
    
    
    var color = UIColor(red: worldRed, green: worldGreen, blue: worldBlue) // rbg값
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityLbl.adjustsFontSizeToFitWidth = true
        cityLbl.numberOfLines = 1
        
        tempLbl.adjustsFontSizeToFitWidth = true
        tempLbl.numberOfLines = 1
        
        weatherLbl.adjustsFontSizeToFitWidth = true
        weatherLbl.numberOfLines = 1
        
        nowRainLbl.adjustsFontSizeToFitWidth = true
        nowRainLbl.numberOfLines = 1
        
        snowLbl.adjustsFontSizeToFitWidth = true
        snowLbl.numberOfLines = 1
        
        
        
        umbrellaLbl.adjustsFontSizeToFitWidth = true
        umbrellaLbl.numberOfLines = 1
        
        
        
        timeLbl.adjustsFontSizeToFitWidth = true
        timeLbl.numberOfLines = 1
        
        
        
        print("이게 다시 나오나")
        
        /*
         
         let userDefaults = UserDefaults.standard // 이게 값을 불러오는건데 애매하다. // default가 없으니깐 문제
         if let red = userDefaults.value(forKey: Setting.RGB.red.rawValue),
             let green = userDefaults.value(forKey: Setting.RGB.green.rawValue),
             let blue = userDefaults.value(forKey: Setting.RGB.blue.rawValue),
             let range = userDefaults.value(forKey: Setting.TIME.range.rawValue)
         {
         */
        print("테스트 해봄")
        
        print(UserDefaults.standard.value(forKey: Setting.RGB.blue.rawValue))
        
        if UserDefaults.standard.value(forKey: Setting.RGB.red.rawValue) == nil &&
            UserDefaults.standard.value(forKey: Setting.RGB.green.rawValue) == nil &&
            UserDefaults.standard.value(forKey: Setting.RGB.blue.rawValue) == nil

            {

                print("이거 최초로 하긴 하나?")

                UserDefaults.standard.set(0, forKey: Setting.RGB.red.rawValue)
                UserDefaults.standard.set(0, forKey: Setting.RGB.green.rawValue)
                UserDefaults.standard.set(0, forKey: Setting.RGB.blue.rawValue)
                UserDefaults.standard.set(0, forKey: Setting.RGB.colorCheck.rawValue)
                UserDefaults.standard.set(6, forKey: Setting.TIME.range.rawValue)

                UserDefaults.standard.set("AM", forKey: Setting.Alert.twelvehour.rawValue)
                UserDefaults.standard.set(0, forKey: Setting.Alert.hour.rawValue)
                UserDefaults.standard.set(0, forKey: Setting.Alert.minute.rawValue)
                UserDefaults.standard.set(false, forKey: Setting.Alert.reservation.rawValue)
                
                
                UserDefaults.standard.synchronize()
                
                setState()

            }
        
        print(UserDefaults.standard.value(forKey: Setting.RGB.blue.rawValue))
        
     
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert], completionHandler: { (didAllow, error) in
        })
        UNUserNotificationCenter.current().delegate = self
        
        
        requestLocationPermision()
        
        // Do any additional setup after loading the view.
        setState()
        color = UIColor(red: worldRed, green: worldGreen, blue: worldBlue)
        
        setState()
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView2.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
               
        worldRangeLbl.text = "\(worldRange*3) Hour"
    
        /* ************* Swipe Area ************* */
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        
        
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        /* ************* Swipe Area ************* */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cityLbl.adjustsFontSizeToFitWidth = true
        cityLbl.numberOfLines = 1
        
        tempLbl.adjustsFontSizeToFitWidth = true
        tempLbl.numberOfLines = 1
        
        weatherLbl.adjustsFontSizeToFitWidth = true
        weatherLbl.numberOfLines = 1
        
        nowRainLbl.adjustsFontSizeToFitWidth = true
        nowRainLbl.numberOfLines = 1
        
        snowLbl.adjustsFontSizeToFitWidth = true
        snowLbl.numberOfLines = 1
        
        umbrellaLbl.adjustsFontSizeToFitWidth = true
        umbrellaLbl.numberOfLines = 1
        
        
        timeLbl.adjustsFontSizeToFitWidth = true
        timeLbl.numberOfLines = 1
        
        
        requestLocationPermision()
        // Do any additional setup after loading the view.
        setState()
        color = UIColor(red: worldRed, green: worldGreen, blue: worldBlue)
        
        
        
        print("빨강 \(worldRed)")
        print("초록 \(worldGreen)")
        print("파랑 \(worldBlue)")
        
        setState()
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView2.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        
       
        // mainVC 이탈했다가 복귀할때마다 색깔들은 월드rgb에 따라 복구
        
        
        print("will appear인데.....")
        
        
        
        print("이거는 appear")
        worldRangeLbl.text = "\(worldRange*3) Hour"
        
        /* ************* Swipe Area ************* */
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        
        
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
        
        /* ************* Swipe Area ************* */
        
    }
    
    func requestLocationPermision() {
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
            loadCurrentWeather()
            manager.stopUpdatingLocation()
        }
    }
    
    class func isLocationEnabled() -> (status: Bool, message: String) {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return (false,"No access")
            case .authorizedAlways, .authorizedWhenInUse:
                return(true,"Access")
            }
        } else {
            return(false,"Turn On Location Services to Allow App to Determine Your Location")
        }
    }
    
    
    @IBAction func settingBtnWasPressed(_ sender: Any) {
        // imsicount는 리셋시킨다.
        
        if let SettingVC = self.storyboard?.instantiateViewController(withIdentifier: "settingVC"){
            imsiCount = 0
            loadCurrentWeather()
           
            self.present(SettingVC, animated: true, completion: nil)
            
            
        }
        
    }
    
    @IBAction func rerunBtnWasPressed(_ sender: Any) {
        
        //새로고침으로 간다
        imsiCount = 0
      
        highRainGrade = 0
        highSnowGrade = 0
        requestLocationPermision()

        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        colorView2.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        
    }
    
    // snow도 rain처럼 개편
    func loadCurrentWeather() {
        let url = "\(BASEURL)\(WEATHER)lat=\(lat)&lon=\(lng)&appid=\(APIKEY)"//"&units=\(units)"
        
        print(url)
        print(lat)
        print(lng)
        
        var firstId = 0
        var dayOrNight = ""
        var outputIcon = ""
        
        var totalPrecipitation: Float = 0.0
        
        
        var nowSnowfall: Float = 0.0
        
        var nowPrecipitation: Float = 0.0
        
        
        var areaRainPrecipitation: Float = 0.0
        
        var areaSnowPrecipitation: Float = 0.0
        
        //var rainCount = 0
        
        //var avgPrecipitation: Float = 0.0
        
        let umbrellaAttributedString = NSMutableAttributedString(string: "")
        let umbrellaImageAttachment = NSTextAttachment()
        umbrellaImageAttachment.image = UIImage(named: "umbrella")
        umbrellaImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        umbrellaAttributedString.append(NSAttributedString(attachment: umbrellaImageAttachment))
        
        let snowAttributedString = NSMutableAttributedString(string: "")
        let snowImageAttachment = NSTextAttachment()
        snowImageAttachment.image = UIImage(named: "snowflake")
        snowImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        snowAttributedString.append(NSAttributedString(attachment: snowImageAttachment))
        
        let tempAttributedString = NSMutableAttributedString(string: "")
        let tempImageAttachment = NSTextAttachment()
        tempImageAttachment.image = UIImage(named: "thermometer")
        tempImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        tempAttributedString.append(NSAttributedString(attachment: tempImageAttachment))
        
        let locationAttributedString = NSMutableAttributedString(string: "")
        let locationImageAttachment = NSTextAttachment()
        locationImageAttachment.image = UIImage(named: "location")
        locationImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        locationAttributedString.append(NSAttributedString(attachment: locationImageAttachment))
        
        let classAttributedString = NSMutableAttributedString(string: "")
        let classImageAttachment = NSTextAttachment()
        classImageAttachment.image = UIImage(named: "Magnifying Glass")
        classImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        classAttributedString.append(NSAttributedString(attachment: classImageAttachment))
        
        
        
   
        var umbrellaIdArray = [Int]()
        var umbrellaDecideArray = [String]()
        
        Alamofire.request(url).responseJSON { response in // 이제 24시간의 양을 스캔 굴려봐야함
            if let json = response.result.value as? [String: Any] { // 지역
                
               
              
                
                if let city = json["city"] as? [String:Any] {
                    if let name = city["name"] as? String {
                        //print("city=\(name)")
                        
                        locationAttributedString.append(NSAttributedString(string: " \(name)"))
                        self.cityLbl.attributedText = locationAttributedString
                        self.cityLbl.sizeToFit()
                
                    }
                    
                    if let timeZ = city["timezone"] as? NSNumber {
                        print("어윤수")
                        print("타임 라인 \(timeZ)")
                        self.timeLine = Int(timeZ)
                        
                    }
                    
                    
                }
                
                
                // 스캔을 때려야 할때
                if let list = json["list"] as? [[String:Any]] {
                    
                    // for
                    for i in self.imsiCount..<self.imsiCount + worldRange {
                        
                        if let rain = list[i]["rain"] as? [String:Any] {
                            if let threerain = rain["3h"] as? NSNumber {
                                
                                let a = threerain.floatValue
                                if i == self.imsiCount {
                                    print("지금 강수량")
                                    print(a)
                                    nowPrecipitation = a
                                }
//                                if a != 0.0 {
//                                    rainCount = rainCount + 1
//                                }
                                areaRainPrecipitation = a
                                totalPrecipitation = totalPrecipitation + a
                                
                                
                                //totalPrecipitation = totalPrecipitation + Int(truncating: threerain)
                                //Precipitation.append(threerain)
                                //print(totalPrecipitation)
                            }
                        }
                        
                        if let snow = list[i]["snow"] as? [String:Any] {
                            if let threesnow = snow["3h"] as? NSNumber {
                                //print("snow 3h: \(threesnow)") // 3시간동안의 강수량 // 누적이니깐 for문 돌린다
                                let a = threesnow.floatValue
                                if i == self.imsiCount {
                                    print("지금 강설량")
                                    print(a)
                                    nowSnowfall = a
                                }
                                
                                areaSnowPrecipitation = a
                                
                                
                                
                                //nowSnowfall = nowSnowfall + a
                                //nowSnowfall = nowSnowfall + Int(truncating: threesnow)
                                
                                //Snowfall.append(threesnow)
                                //print(nowSnowfall)
                            }
                        }
                        
                        if let weather2 = list[i]["weather"] as? [[String:Any]] {
                            if let desc = weather2[0]["description"] as? String {
                                print(desc) // 나와있는 것들을 추합해서 결정한다.
                                umbrellaDecideArray.append(desc)
                                // 추합한 다음 이걸 함수로 보내버려야
                                
                            }
                            
                            if let id = weather2[0]["id"] as? NSNumber {
                                print("id 값 \(id)")
                                let a = id.intValue
                                umbrellaIdArray.append(a)
                                if i == self.imsiCount {
                                    print("이게 최초의 id값")
                                    firstId = a
                                }
                                
                                
                            }
                        }
                        
                        
                        print("\(i)번쨰 \(areaRainPrecipitation)") // 지표2
                        
                       // print("카운트 \(rainCount)")
                        
                        self.judgeAreaRain(areaRainPrecipitation)
                        self.judgeAreaSnow(areaSnowPrecipitation)
                        
                        print("현재 강수량 \(nowPrecipitation)")
                        
                        
                        
                    } //for
                    
                    //print(umbrellaDecideArray)
                    //print(umbrellaIdArray)
                    
                    //print("현재 강수량 \(nowPrecipitation)")
                    
                    
                    print("\(self.highRainGrade)등급")
                    print("\(self.highSnowGrade)등급")
                    self.message(self.highRainGrade, self.highSnowGrade)
                    
                    
                    
                    
                    
                    if let main = list[self.imsiCount]["main"] as? [String:Any] { // list의 1라인이다. //
                        
                        
                        if let temp = main["temp"] as? NSNumber { // NSNUMBER 고정 현재 온도
                            print("temp=\(temp)")
                            var a = temp.floatValue
                            a = a - 273.15
                            let cutA = String(format: "%.1f", a)
                            
                            tempAttributedString.append(NSAttributedString(string: " \(cutA)°C"))
                            self.tempLbl.attributedText = tempAttributedString
                            self.tempLbl.sizeToFit()
                           
                            
                            
                        }
                        
                    }
                    
                    
                    if let dt_txt = list[self.imsiCount]["dt_txt"] as? String { // 시간대는 포함 x
                       
                       
                        
                        
                        let dateString:String = dt_txt
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        dateFormatter.timeZone = NSTimeZone(name:"UTC") as TimeZone?
                        var date:Date = dateFormatter.date(from: dateString)! // String을 date로 변환
                        
                       
                       
                        print("테스트 \(date)")
                        let dd = date.toString(dateFormat: "yyyy-MM-dd HH:mm:ss", timezone: self.timeLine)
                        print(dd)
                        self.timeLbl.text = "\(dd)"
                        
               
                        
                    }
                    
                    if let weather = list[self.imsiCount]["weather"] as? [[String:Any]] { // 메인 날씨 view + 아이콘까지 나중에 나와야
                        if let main = weather[0]["main"] as? String {
                            print("메인 이벤트 \(main)")// 뜨나?
                            
                            
                            classAttributedString.append(NSAttributedString(string: " \(main)"))
                            self.weatherLbl.attributedText = classAttributedString
                            self.weatherLbl.sizeToFit()

                            
                            //self.weatherLbl.text = main
                        }
                        
                        if let icon = weather[0]["icon"] as? String {
                            print("아이콘을 보자 \(icon)")
                            
                            
                            print(icon[icon.index(before: icon.endIndex)]) // d or n
                            dayOrNight = "\(icon[icon.index(before: icon.endIndex)])"
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }
            
            
            print("first id \(firstId)")
            print("day of night |\(dayOrNight)|")
            
            outputIcon = self.weatherIconOut(weatherId: firstId, dayOrNight: dayOrNight)
            print("outputIcon \(outputIcon)")
            
            self.iconImageView.image = UIImage(named: "\(outputIcon).png")
            
            print("총 강수량 \(totalPrecipitation)")
            print("총 적설량 \(nowSnowfall)")
        
            
            
            // 총 강수량에서 raincount로 나누면 평균 강수량이 뜰듯
            //avgPrecipitation = (totalPrecipitation / Float(rainCount))
            if totalPrecipitation != 0.0 {
                //print("평균 강수량 \(avgPrecipitation)") // 지표1
               // self.judgeAverageRain(avgPrecipitation)
            }

            
            
            if nowSnowfall != 0.0 {
                
                snowAttributedString.append(NSAttributedString(string: " \(nowSnowfall)mm"))
                self.snowLbl.attributedText = snowAttributedString
                self.snowLbl.sizeToFit()
               
            } else {
                snowAttributedString.append(NSAttributedString(string: ""))
                self.snowLbl.attributedText = snowAttributedString
                self.snowLbl.sizeToFit()
            }
            
            if nowPrecipitation != 0.0 {
                
                umbrellaAttributedString.append(NSAttributedString(string: " \(nowPrecipitation)mm"))
                self.nowRainLbl.attributedText = umbrellaAttributedString
                self.nowRainLbl.sizeToFit()
            } else {
                umbrellaAttributedString.append(NSAttributedString(string: ""))
                self.nowRainLbl.attributedText = umbrellaAttributedString
                self.nowRainLbl.sizeToFit()
            }
            
            
        }
        
    }
    
    func showAlert(_ message:String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    func judgeAreaRain(_ currentRain: Float){
        // n번의 횟수동안 해당 영역의 강수량에 대한 판단
        // 1. 0mm : 우산을 안가져가도 되는 수준
        // 2. 1mm미만 : 안가져가도 괜찮긴 한데 비가 아예 안오지는 않음
        // 3. 1mm이상 3mm미만 : 가져가는게 괜찮다. 비가 온다.
        // 4. 3mm 이상 : 무조건 가져가야한다.
        print("현재 영역의 강수량 \(currentRain)")
        if currentRain == 0.0 {
            print("우산을 안가져가도 되는 수준")
        } else if currentRain > 0.0 && currentRain < 1.0 {
            print("안가져가도 괜찮긴 한데 비가 아예 안오지는 않음")
            if highRainGrade == 0 {
                highRainGrade = 1
            }
        } else if currentRain > 1.0 && currentRain < 3.0 {
            print("가져가는게 괜찮다. 비가 온다.")
            if highRainGrade >= 0 && highRainGrade <= 1 {
                highRainGrade = 2
            }
        } else if currentRain > 3.0 {
            
            print("무조건 가져가야한다.")
            if highRainGrade >= 0 && highRainGrade <= 2 {
                highRainGrade = 3
            }
        }
        
    }
    
    
       func judgeAreaSnow(_ currentSnow: Float){ // 눈
           
           print("현재 영역의 강수량 \(currentSnow)")
           if currentSnow == 0.0 {
               print("우산을 안가져가도 되는 수준")
           } else if currentSnow > 0.0 && currentSnow < 1.0 {
               print("안가져가도 괜찮긴 한데 비가 아예 안오지는 않음")
               if highSnowGrade == 0 {
                   highSnowGrade = 1
               }
           } else if currentSnow > 1.0 && currentSnow < 3.0 {
               print("가져가는게 괜찮다. 비가 온다.")
               if highSnowGrade >= 0 && highSnowGrade <= 1 {
                   highSnowGrade = 2
               }
           } else if currentSnow > 3.0 {
               print("무조건 가져가야한다.")
               if highSnowGrade >= 0 && highSnowGrade <= 2 {
                   highSnowGrade = 3
               }
           }
           
       }
       
    
    
    
//    func judgeAverageRain(_ averageRain: Float) {
//
//        // n번의 횟수동안 총 강수량에 대한 평균
//        // 1. 0mm : 우산을 안가져가도 되는 수준
//        // 2. 1mm미만 : 안가져가도 괜찮긴 한데 비가 아예 안오지는 않음
//        // 3. 1mm이상 3mm미만 : 가져가는게 괜찮다. 비가 온다.
//        // 4. 3mm 이상 : 무조건 가져가야한다.
//
//        print("평균적인 강수량은 \(averageRain)")
//        if averageRain == 0.0 {
//            print("우산을 안가져가도 되는 수준")
//        } else if averageRain > 0.0 && averageRain < 1.0 {
//            print("안가져가도 괜찮긴 한데 비가 아예 안오지는 않음")
//        } else if averageRain > 1.0 && averageRain < 3.0 {
//            print("가져가는게 괜찮다. 비가 온다.")
//        } else if averageRain > 3.0 {
//            print("무조건 가져가야한다.")
//        }
//    }
//
    
    func message(_ rain: Int, _ snow: Int) {
        
        let resultAttributedString = NSMutableAttributedString(string: "")
        let resultImageAttachment = NSTextAttachment()
        resultImageAttachment.image = UIImage(named: "result")
        resultImageAttachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        resultAttributedString.append(NSAttributedString(attachment: resultImageAttachment))
        
        
        if rain == snow {
            if rain == 0 {
                
                resultAttributedString.append(NSAttributedString(string: " 우산이 필요없습니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            if rain == 1 {
                resultAttributedString.append(NSAttributedString(string: " 혹시 모르니깐 챙겨갑시다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if rain == 2 {
                resultAttributedString.append(NSAttributedString(string: " 챙겨가는게 좋습니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if rain == 3 {
                resultAttributedString.append(NSAttributedString(string: " 무조건 챙겨야 합니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
        }
        
        if rain > snow {
            
            if rain == 1 {
                resultAttributedString.append(NSAttributedString(string: " 혹시 모르니깐 챙겨갑시다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if rain == 2 {
                resultAttributedString.append(NSAttributedString(string: " 챙겨가는게 좋습니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if rain == 3 {
                resultAttributedString.append(NSAttributedString(string: " 무조건 챙겨야 합니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
        }
        
        if snow > rain {
            
            if snow == 1 {
                resultAttributedString.append(NSAttributedString(string: " 혹시 모르니깐 챙겨갑시다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if snow == 2 {
                resultAttributedString.append(NSAttributedString(string: " 챙겨가는게 좋습니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
            
            if snow == 3 {
                resultAttributedString.append(NSAttributedString(string: " 무조건 챙겨야 합니다"))
                self.umbrellaLbl.attributedText = resultAttributedString
                self.umbrellaLbl.sizeToFit()
            }
        }
    }
    
    
    func weatherIconOut(weatherId: Int, dayOrNight: String) -> String
    {
        // ddy or night 구분 하는걸 하나 더 추가해야할듯
        
        var icon = ""
        
        // day
        if dayOrNight == "d" {
            
        switch weatherId {
        case 200,201,202,230,231,232:
            icon = "day_rain_thunder";
            break
        case 210,211,212,221:
            icon = "thunder";
            break
        case 300,301,302,310,311,312,313,314,321:
            icon = "rain";
            break
        case 500,501,502,503,504,520,521,522,531:
            icon = "day_rain";
            break
        case 511,612,613,615,616:
            icon = "day_sleet";
            break
        case 600,601,602,611,620,621,622:
            icon = "day_snow";
            break
        case 701,751:
            icon = "mist";
            break
        case 771:
            icon = "wind";
            break
        case 711,721,731,741,761,762:
            icon = "fog";
            break
        case 781:
            icon = "tornado";
            break
        case 800:
            icon = "day_clear";
            break
        case 801:
            icon = "day_partial_cloud";
            break
        case 802:
            icon = "cloudy";
            break
        case 803,804:
            icon = "overcast";
            break
            
        default:
            break
        }
            
        }
        
        // night
        
        if dayOrNight == "n" {
        
        switch weatherId {
        case 200,201,202,230,231,232:
            icon = "night_full_moon_rain_thunder";
            break
        case 210,211,212,221:
            icon = "thunder";
            break
        case 300,301,302,310,311,312,313,314,321:
            icon = "rain";
            break
        case 500,501,502,503,504,520,521,522,531:
            icon = "night_full_moon_rain";
            break
        case 511,612,613,615,616:
            icon = "night_full_moon_sleet";
            break
        case 600,601,602,611,620,621,622:
            icon = "night_full_moon_snow";
            break
        case 701,751:
            icon = "mist";
            break
        case 771:
            icon = "wind";
            break
        case 711,721,731,741,761,762:
            icon = "fog";
            break
        case 781:
            icon = "tornado";
            break
        case 800:
            icon = "night_full_moon_clear";
            break
        case 801:
            icon = "night_full_moon_partial_cloud";
            break
        case 802:
            icon = "cloudy";
            break
        case 803,804:
            icon = "overcast";
            break
            
        default:
            break
        }
            
        }
        
        return icon
        
        
    }
   
    
    
    
    @IBAction func beforeBtnWasPressed(_ sender: Any) {
        // index 최소값 2.
        // 갯수는 40개
        // [0]~[39]
        // range :  12시간, 18시간, 24시간
        //
        
        if imsiCount > 0 {
            imsiCount = imsiCount - 1
        
            highRainGrade = 0
            highSnowGrade = 0
            loadCurrentWeather()
        } else {
            print("최소값 한계터졌다")
        }
        
        
    }
    
    
    @IBAction func afterBtnWasPressed(_ sender: Any) {
        
        // 맥심값이 40이니깐.... // 배열상 39까지
        // 기본값 + [4,5,6,7,8]
        
        
        // 2.. <2+6
        // 2.. <2+7
        // 2.. <2+8
        
        // 34.. <34+4 : 37까지네 [34,35,36,37]
        // 34.. <34+5 : 38까지네 [34,35,36,37,38]
        // 34.. <34+6 : 39까지네 [34,35,36,37,38,39]
        // 34.. <34+7 : 40까지는 안됨 [34,35,36,37,38,39,40 xxxx]
        
        // (imsicount + rangeIndex) = 40까지는 가능, 41이 넘어가면 나가리
        
        if (imsiCount + worldRange) <= 39 {
            print("합계 \(imsiCount + worldRange)")
            imsiCount = imsiCount + 1
            
            highRainGrade = 0
            highSnowGrade = 0
            loadCurrentWeather()
            //print("합계 \(imsiCount + rangeIndex)")
        } else {
            print("최대값 한계터졌다")
            // 이제 rangeIndex를 설정에서 바꿔줘야 함
        }
        
        
        
    }
    
    
    @IBAction func firstBtnWasPressed(_ sender: Any) {
        imsiCount = 0

        highRainGrade = 0
        highSnowGrade = 0
        loadCurrentWeather()
        // 누르면 0스타트
        
    }
    
    @IBAction func lastBtnWasPressed(_ sender: Any) {
        // imsiCount,worldRange 더하면 40이네?
        
        imsiCount = 40 - worldRange
       
        highRainGrade = 0
        loadCurrentWeather()
        
        
        
        // 누르면 끝까지
    }
    
    
    
    // test btn으로 api값을 달리 보이게 만들 것
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if (sender.direction == .left) {
            print("Swipe Left")
            
            if (imsiCount + worldRange) <= 39 {
                print("합계 \(imsiCount + worldRange)")
                imsiCount = imsiCount + 1
               
                loadCurrentWeather()
                //print("합계 \(imsiCount + rangeIndex)")
            } else {
                print("최대값 한계터졌다")
                // 이제 rangeIndex를 설정에서 바꿔줘야 함
            }
            
            // ㅅㅣ점 변경
        }
        
        if (sender.direction == .right) {
            print("Swipe Right")
            
            
            
            if imsiCount > 0 {
                imsiCount = imsiCount - 1
               
                loadCurrentWeather()
            } else {
                print("최소값 한계터졌다")
            }
            
        }
        
        if (sender.direction == .up) {
            print("Swipe Up")
            
        }
        
        if (sender.direction == .down) {
            print("Swipe Down")
            
        }
    }
    
    // 우리는 view에 대한 swipe 기능을 넣을 것 이다
    // left, right 3시간 단위의 기준을 변경하는 작업
   
    
    
    
    
    
}


extension MainVC {
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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}



extension Date {
    
    func toString( dateFormat format: String, timezone: Int ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: timezone)
        //dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }

}


extension MainVC : UNUserNotificationCenterDelegate {
      func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
         completionHandler([.alert, .sound, .badge])
     }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
        
        
    }
}

// part1
// real time 출력?
// 배경은 어떤식으로 할 것 인가
// 우산을 써야한다면 그 output은 텍스트가아닌 이미지로 표현하는게 좋다고 봄
// 배경부분은 차후에 ui를 맞춰서 가는걸로
// 설정에서 바꿔야 하는 부분들을 찾아야 함 :
//



// part2.
// 현재 기준으로 불러오는건 가능
// 이제 내가 설정한 날짜를 불러와야하는데 이게 5day까지인거를 생각해야함
// 스크롤을 하던 뭐 어떤식으로 하던 유동적으로 데이터가 보여줘야 한다고 봄
// 유동적으로 구성만 된다면 ui부분은 순조롭게 가능
// download를 사전에 받아야 하는듯?


// part3
// userdefault를 활용해서 설정값 자체는 계속 지속적으로 유지 가능 // 일단 저장은 잘 돌아감
// 설정바꿔주는 것들 : ui에 대한 컬러 설정, 우산 판정에 대한 기준시간, 단순 view를 해주는 정보들(소스출처, 본인소개, 버전 등) //
// 범위만 userDefalut로 전환 해주면 됨
// 이제 setting에서 컬러를 바꿔주자. 테스트 한번 굴려보고 가즈아
// 컬러 바꿔줄 수 있음 // 범위도 끝
// 컬러설정은 pod 불러와서 rgb값 토스해주고 적용과 저장을 동시에 굴려버림
// ui문제
// mainVC에서 화면을 아래로 땡기면 새로고침 되도록 설정을 추가해야함. (동작에 의한 작동을 몇가지 추가해야할듯)
// 정돈된 UI를 구상해야 할듯
// 각각의 설정을 하는 부분을 VIEW로 다 만들어주는게 편할려나?
//

