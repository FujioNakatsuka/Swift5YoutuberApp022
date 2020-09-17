//
//  WebViewController.swift
//  Swift5YoutuberApp022
//
//  Created by 中塚富士雄 on 2020/09/17.
//  Copyright © 2020 中塚富士雄. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
    
        view.addSubview(webView)
        
        if UserDefaults.standard.object(forKey: "url") != nil{
            
            let urlString = UserDefaults.standard.object(forKey: "url")
            let url = URL(string: urlString as! String)
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    
    }
    
}
