//
//  OpenSourceExplainVC.swift
//  UmbrellaWeather
//
//  Created by 김영석 on 2020/04/14.
//  Copyright © 2020 김영석. All rights reserved.
//

import UIKit

class OpenSourceExplainVC: UIViewController {
    
    // open source explain + select open source + theme color on
    
    let IGColorPicker = "Copyright (c) 2017 iGenius Srl Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \n\n The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. \n\n THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
    
    let GoogleMaps = "3. License. \n\n 3.1 License Grant. Subject to the Agreement's terms, during the Term, Google grants to Customer a non-exclusive, non-transferable, non-sublicensable, license to use the Services in Customer Application(s). /n/n 3.2 License Requirements and Restrictions. The following are conditions of the license granted in Section 3.1 (License Grant). In this Section 3.2 (License Requirements and Restrictions), the phrase \"Customer will not\" means \"Customer will not, and will not permit a third party to\". \n\n 3.2.1 General Restrictions. Customer will not: (a) copy, modify, create a derivative work of, reverse engineer, decompile, translate, disassemble, or otherwise attempt to extract any or all of the source code (except to the extent such restriction is expressly prohibited by applicable law); (b) sublicense, transfer, or distribute any of the Services; (c) sell, resell, sublicense, transfer, or distribute the Services; or (d) access or use the Services: (i) for High Risk Activities; (ii) in a manner intended to avoid incurring Fees; (iii) for materials or activities that are subject to the International Traffic in Arms Regulations (ITAR) maintained by the United States Department of State; (iv) in a manner that breaches, or causes the breach of, Export Control Laws; or (v) to transmit, store, or process health information subject to United States HIPAA regulations. \n\n 3.2.2 Requirements for Using the Services. \n\n (a) Terms of Service and Privacy Policy. \n\n (i) The Customer Application’s terms of service will (A) notify users that the Customer Application includes Google Maps features and content; and (B) state that use of Google Maps features and content is subject to the then-current versions of the: (1) Google Maps/Google Earth Additional Terms of Service at https://maps.google.com/help/terms_maps.html; and (2) Google Privacy Policy at https://www.google.com/policies/privacy/. \n\n (ii) If the Customer Application allows users to include the Google Maps Core Services in Downstream Products, then Customer will contractually require that all Downstream Products’ terms of service satisfy the same notice and flow-down requirements that apply to the Customer Application under Section 3.2.2 (a) (i) (Terms of Service and Privacy Policy). \n\n (iii) If users of the Customer Application (and Downstream Products, if any) fail to comply with the applicable terms of the Google Maps/Google Earth Additional Terms of Service, then Customer will take appropriate enforcement action, including Suspending or terminating those users’ use of Google Maps features and content in the Customer Application or Downstream Products. \n\n (b) Attribution.  Customer will display all attribution that (i) Google provides through the Services (including branding, logos, and copyright and trademark notices); or (ii) is specified in the Maps Service Specific Terms. Customer will not modify, obscure, or delete such attribution. \n\n (c) Review of Customer Applications. At Google’s request, Customer will submit Customer Application(s) and Project(s) to Google for review to ensure compliance with the Agreement (including the AUP). \n\n 3.2.3 Restrictions Against Misusing the Services. \n\n (a)  No Scraping. Customer will not export, extract, or otherwise scrape Google Maps Content for use outside the Services. For example, Customer will not: (i) pre-fetch, index, store, reshare, or rehost Google Maps Content outside the services; (ii) bulk download Google Maps tiles, Street View images, geocodes, directions, distance matrix results, roads information, places information, elevation values, and time zone details; (iii) copy and save business names, addresses, or user reviews; or (iv) use Google Maps Content with text-to-speech services. \n\n (b) No Caching. Customer will not cache Google Maps Content except as expressly permitted under the Maps Service Specific Terms. \n\n (c) No Creating Content From Google Maps Content. Customer will not create content based on Google Maps Content. For example, Customer will not: (i) trace or digitize roadways, building outlines, utility posts, or electrical lines from the Maps JavaScript API Satellite base map type; (ii) create 3D building models from 45° Imagery from Maps JavaScript API; (iii) build terrain models based on elevation values from the Elevation API; (iv) use latitude/longitude values from the Places API as an input for point-in-polygon analysis; (v) construct an index of tree locations within a city from Street View imagery; or (vi) convert text-based driving times into synthesized speech results. \n\n (d) No Re-Creating Google Products or Features. Customer will not use the Services to create a product or service with features that are substantially similar to or that re-create the features of another Google product or service. Customer’s product or service must contain substantial, independent value and features beyond the Google products or services. For example, Customer will not: (i) re-distribute the Google Maps Core Services or pass them off as if they were Customer’s services; (ii) create a substitute of the Google Maps Core Services, Google Maps, or Google Maps mobile apps, or their features; (iii) use the Google Maps Core Services in a listings or directory service or to create or augment an advertising product; (iv) combine data from the Directions API, Geolocation API, and Maps SDK for Android to create real-time navigation functionality substantially similar to the functionality provided by the Google Maps for Android mobile app. \n\n (e) No Use With Non-Google Maps. To avoid quality issues and/or brand confusion, Customer will not use the Google Maps Core Services with or near a non-Google Map in a Customer Application. For example, Customer will not (i) display or use Places content on a non-Google map, (ii) display Street View imagery and non-Google maps on the same screen, or (iii) link a Google Map to non-Google Maps content for a non-Google map. \n\n (f) No Circumventing Fees. Customer will not circumvent the applicable Fees. For example, Customer will not create multiple billing accounts or Projects to avoid incurring Fees, prevent Google from accurately calculating Customer’s Service usage levels, abuse any free Service quotas, or offer access to the Services under a “time-sharing” or “service bureau” model.\n\n (g) No Use in Prohibited Territories. Customer will not distribute or market in a Prohibited Territory any Customer Application(s) that use the Google Maps Core Services. \n\n (h) No Use in Embedded Vehicle Systems. Customer will not use the Google Maps Core Services in connection with any Customer Application or device embedded in a vehicle. For example, Customer will not create a Customer Application that (i) is embedded in an in-dashboard automotive infotainment system; and (ii) allows End Users to request driving directions from the Directions API. \n\n (i)  No Use in Customer Application Directed To Children. Customer will not use the Google Maps Core Services in a Customer Application that would be deemed to be a “Web site or online service directed to children” under the Children’s Online Privacy Protection Act (COPPA). \n\n (j) No Modifying Search Results Integrity. Customer will not modify any of the Google Maps Core Service’s search results. \n\n 3.2.4 Benchmarking. Customer may not publicly disclose directly or through a third party the results of any comparative or compatibility testing, benchmarking, or evaluation of the Services (each, a “Test”), unless the disclosure includes all information necessary for Google or a third party to replicate the Test. If Customer conducts, or directs a third party to conduct, a Test of the Services and publicly discloses the results directly or through a third party, then Google (or a Google directed third party) may conduct Tests of any publicly available cloud products or services provided by Customer and publicly disclose the results of any such Test (which disclosure will include all information necessary for Customer or a third party to replicate the Test)."
    
    let GooglePlaces = "3. License. \n\n 3.1 License Grant. Subject to the Agreement's terms, during the Term, Google grants to Customer a non-exclusive, non-transferable, non-sublicensable, license to use the Services in Customer Application(s). \n\n 3.2 License Requirements and Restrictions. The following are conditions of the license granted in Section 3.1 (License Grant). In this Section 3.2 (License Requirements and Restrictions), the phrase \"Customer will not” means “Customer will not, and will not permit a third party to\". \n\n 3.2.1 General Restrictions. Customer will not: (a) copy, modify, create a derivative work of, reverse engineer, decompile, translate, disassemble, or otherwise attempt to extract any or all of the source code (except to the extent such restriction is expressly prohibited by applicable law); (b) sublicense, transfer, or distribute any of the Services; (c) sell, resell, sublicense, transfer, or distribute the Services; or (d) access or use the Services: (i) for High Risk Activities; (ii) in a manner intended to avoid incurring Fees; (iii) for materials or activities that are subject to the International Traffic in Arms Regulations (ITAR) maintained by the United States Department of State; (iv) in a manner that breaches, or causes the breach of, Export Control Laws; or (v) to transmit, store, or process health information subject to United States HIPAA regulations. \n\n 3.2.2 Requirements for Using the Services. \n\n (a) Terms of Service and Privacy Policy. \n\n (i) The Customer Application’s terms of service will (A) notify users that the Customer Application includes Google Maps features and content; and (B) state that use of Google Maps features and content is subject to the then-current versions of the: (1) Google Maps/Google Earth Additional Terms of Service at https://maps.google.com/help/terms_maps.html; and (2) Google Privacy Policy at https://www.google.com/policies/privacy/. \n\n (ii) If the Customer Application allows users to include the Google Maps Core Services in Downstream Products, then Customer will contractually require that all Downstream Products’ terms of service satisfy the same notice and flow-down requirements that apply to the Customer Application under Section 3.2.2 (a) (i) (Terms of Service and Privacy Policy). \n\n (iii) If users of the Customer Application (and Downstream Products, if any) fail to comply with the applicable terms of the Google Maps/Google Earth Additional Terms of Service, then Customer will take appropriate enforcement action, including Suspending or terminating those users’ use of Google Maps features and content in the Customer Application or Downstream Products. \n\n (b) Attribution.  Customer will display all attribution that (i) Google provides through the Services (including branding, logos, and copyright and trademark notices); or (ii) is specified in the Maps Service Specific Terms. Customer will not modify, obscure, or delete such attribution. \n\n (c) Review of Customer Applications. At Google’s request, Customer will submit Customer Application(s) and Project(s) to Google for review to ensure compliance with the Agreement (including the AUP). \n\n 3.2.3 Restrictions Against Misusing the Services. \n\n (a)  No Scraping. Customer will not export, extract, or otherwise scrape Google Maps Content for use outside the Services. For example, Customer will not: (i) pre-fetch, index, store, reshare, or rehost Google Maps Content outside the services; (ii) bulk download Google Maps tiles, Street View images, geocodes, directions, distance matrix results, roads information, places information, elevation values, and time zone details; (iii) copy and save business names, addresses, or user reviews; or (iv) use Google Maps Content with text-to-speech services. \n\n (b) No Caching. Customer will not cache Google Maps Content except as expressly permitted under the Maps Service Specific Terms. \n\n (c) No Creating Content From Google Maps Content. Customer will not create content based on Google Maps Content. For example, Customer will not: (i) trace or digitize roadways, building outlines, utility posts, or electrical lines from the Maps JavaScript API Satellite base map type; (ii) create 3D building models from 45° Imagery from Maps JavaScript API; (iii) build terrain models based on elevation values from the Elevation API; (iv) use latitude/longitude values from the Places API as an input for point-in-polygon analysis; (v) construct an index of tree locations within a city from Street View imagery; or (vi) convert text-based driving times into synthesized speech results. \n\n (d) No Re-Creating Google Products or Features. Customer will not use the Services to create a product or service with features that are substantially similar to or that re-create the features of another Google product or service. Customer’s product or service must contain substantial, independent value and features beyond the Google products or services. For example, Customer will not: (i) re-distribute the Google Maps Core Services or pass them off as if they were Customer’s services; (ii) create a substitute of the Google Maps Core Services, Google Maps, or Google Maps mobile apps, or their features; (iii) use the Google Maps Core Services in a listings or directory service or to create or augment an advertising product; (iv) combine data from the Directions API, Geolocation API, and Maps SDK for Android to create real-time navigation functionality substantially similar to the functionality provided by the Google Maps for Android mobile app. \n\n (e) No Use With Non-Google Maps. To avoid quality issues and/or brand confusion, Customer will not use the Google Maps Core Services with or near a non-Google Map in a Customer Application. For example, Customer will not (i) display or use Places content on a non-Google map, (ii) display Street View imagery and non-Google maps on the same screen, or (iii) link a Google Map to non-Google Maps content for a non-Google map. \n\n (f) No Circumventing Fees. Customer will not circumvent the applicable Fees. For example, Customer will not create multiple billing accounts or Projects to avoid incurring Fees, prevent Google from accurately calculating Customer’s Service usage levels, abuse any free Service quotas, or offer access to the Services under a “time-sharing” or “service bureau” model. \n\n (g) No Use in Prohibited Territories. Customer will not distribute or market in a Prohibited Territory any Customer Application(s) that use the Google Maps Core Services. \n\n (h) No Use in Embedded Vehicle Systems. Customer will not use the Google Maps Core Services in connection with any Customer Application or device embedded in a vehicle. For example, Customer will not create a Customer Application that (i) is embedded in an in-dashboard automotive infotainment system; and (ii) allows End Users to request driving directions from the Directions API. \n\n (i)  No Use in Customer Application Directed To Children. Customer will not use the Google Maps Core Services in a Customer Application that would be deemed to be a “Web site or online service directed to children” under the Children’s Online Privacy Protection Act (COPPA). \n\n (j) No Modifying Search Results Integrity. Customer will not modify any of the Google Maps Core Service’s search results. \n\n 3.2.4 Benchmarking. Customer may not publicly disclose directly or through a third party the results of any comparative or compatibility testing, benchmarking, or evaluation of the Services (each, a “Test”), unless the disclosure includes all information necessary for Google or a third party to replicate the Test. If Customer conducts, or directs a third party to conduct, a Test of the Services and publicly discloses the results directly or through a third party, then Google (or a Google directed third party) may conduct Tests of any publicly available cloud products or services provided by Customer and publicly disclose the results of any such Test (which disclosure will include all information necessary for Customer or a third party to replicate the Test)."
    
    let Alamofire = "Copyright (c) 2014-2020 Alamofire Software Foundation (http://alamofire.org/) \n\n Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \n\n The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. \n\n THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS INTHE SOFTWARE."
    
    let OpenWeatherAPI = "Licenses \n\n Free weather API is provided under the terms of the Creative Commons Attribution-ShareAlike 4.0 Generic License. \n\n Any use of the work other than as authorized under this license or copyright law is prohibited. \n\n You are free to: \n\n Share — copy and redistribute the material in any medium or format \n\n Adapt — remix, transform, and build upon the material \n\n for any purpose, even commercially. \n\n The licensor cannot revoke these freedoms as long as you follow the license terms. \n\n Under the following terms: \n\n Attribution — You must give appropriate credit, provide a link to the OpenWeatherMap.org, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. \n\n ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original. \n\n No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits. \n\n You do not have to comply with the license for elements of the material in the public domain or where your use is permitted by an applicable exception or limitation. \n\n No warranties are given. The license may not give you all of the permissions necessary for your intended use. For example, other rights such as publicity, privacy, or moral rights may limit how you use the material. \n\n Other licenses different from Creative Commons can be used in Elite accounts under conditions set out in the price-list."
    
    let AAInfographics = "The MIT License (MIT) \n\n Copyright (c) 2015 An An<https://github.com/AAChartModel/AAChartKit-Swift> /n/n Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \n\n The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. \n\n THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sourceLbl: UILabel!
   
    @IBOutlet weak var colorView1: UIView!
    
    
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn.titleLabel!.adjustsFontSizeToFitWidth = true
        backBtn.titleLabel!.numberOfLines = 1
        setState()
        
        sourceLbl.layer.masksToBounds = true
        backBtn.layer.masksToBounds = true
        
        
        colorView1.backgroundColor = UIColor(red: CGFloat(worldRed)/255, green: CGFloat(worldGreen)/255, blue: CGFloat(worldBlue)/255, alpha: 1)
        
        textView.isEditable = false
        
        if openSourceType == "IGColorPicker" {
            textView.text = IGColorPicker
            sourceLbl.text = "IGColorPicker"
        }
        
        if openSourceType == "GoogleMaps" {
            textView.text = GoogleMaps
            sourceLbl.text = "GoogleMaps"
        }
        
        if openSourceType == "GooglePlaces" {
            textView.text = GooglePlaces
            sourceLbl.text = "GooglePlaces"
        }
        
        if openSourceType == "Alamofire" {
            textView.text = Alamofire
            sourceLbl.text = "Alamofire"
        }
        
        if openSourceType == "OpenWeatherAPI" {
            textView.text = OpenWeatherAPI
            sourceLbl.text = "OpenWeatherAPI"
        }
        
        if openSourceType == "AAInfographics" {
            textView.text = AAInfographics
            sourceLbl.text = "AAInfographics"
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
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

extension OpenSourceExplainVC {
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




@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}


