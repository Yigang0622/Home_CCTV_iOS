//
//  ViewController.swift
//  HomeCam
//
//  Created by Yigang Zhou on 2019/12/27.
//  Copyright © 2019 Yigang Zhou. All rights reserved.
//

import UIKit
import AVKit
import WebKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    //水平
    @IBOutlet weak var segOne: UISegmentedControl!
    
    //垂直
    @IBOutlet weak var segTwo: UISegmentedControl!
    
    let config = Configuration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segOne.addTarget(self, action: #selector(self.segOneValueChanged), for: .valueChanged)
        segTwo.addTarget(self, action: #selector(self.segTwoValueChanged), for: .valueChanged)
        
        loadWebView()
    }
    
    
    @IBAction func refreashClicked(_ sender: Any) {
        print("refreshClicked")
        loadWebView()
    }
    
    @IBAction func settingsClicked(_ sender: Any) {
        showSettingsDialog()
    }
    
    func loadWebView(){
        let urlStr = config.getServerUrl() + "/video_feed?token=" + config.getToken()
        print(urlStr)
        let url = URL (string: urlStr);
        let request = URLRequest(url: url!);
        webview.load(request)
        
    }
    
    @objc fileprivate func segOneValueChanged(){
        sendSeroPostionChangeRequest(servo: 0, angle:  segOne.selectedSegmentIndex*30)
    }
    
    @objc fileprivate func segTwoValueChanged(){
        sendSeroPostionChangeRequest(servo: 1, angle:  segTwo.selectedSegmentIndex*30)
    }
    
    fileprivate func sendSeroPostionChangeRequest(servo:Int, angle:Int){
        let parameters: [String: String] = [
            "id": String(servo),
            "angle": String(angle),
            "token": config.getToken()
        ]
        let requestUrl = config.getServerUrl() + "/reposition"
        // All three of these calls are equivalent
        print(requestUrl)
        AF.request(requestUrl, method: .get, parameters: parameters).responseString { (result) in
            print(result.value!)
        }
        
    }
    
    fileprivate func showSettingsDialog(){
           
        let settingMessage = "Server: \(config.getServerUrl())\nToken: \(config.getToken())"

        let alertController = UIAlertController(title: "Settings", message: settingMessage, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            let server = alertController.textFields?[0].text
            let token = alertController.textFields?[1].text
            self.config.setServerUrl(url: server!)
            self.config.setToken(token: token!)

        }


        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }

        alertController.addTextField { (textField) in
            textField.placeholder = "Server Address"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Token"
        }


        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)

    }
    
    
     
    
   
    

}

