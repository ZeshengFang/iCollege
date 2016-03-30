//
//  VideoViewController.swift
//  DayLesson
//
//  Created by fzs on 16/3/17.
//  Copyright © 2016年 fzs. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var navigationView: UIView!
    
    let iframString = "<div class=\"container\"><iframe class=\"video\" src=\"https://embed-ssl.ted.com/talks/jessica_ladd_the_reporting_system_that_sexual_assault_survivors_want.html\" frameborder=\"0\" scrolling=\"no\" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></div>"
    
    let url = "http://www.ted.com/talks/adam_foss_a_prosecutor_s_vision_for_a_better_justice_system"
    var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.configuration.allowsInlineMediaPlayback = true
            webView.configuration.requiresUserActionForMediaPlayback = false
           // webView.scrollView.scrollEnabled = false
        }
    }
    
    override func viewDidLoad() {
       // webView = WKWebView(frame: CGRectMake(0.0, 0.0, self.view.bounds.width - 2.0, 0.0))
//        do {
//            if let scriptURL = NSBundle.mainBundle().pathForResource("videoJS", ofType: "js") {
//                let scriptContent = try String(contentsOfFile: scriptURL, encoding: NSUTF8StringEncoding)
//                let script = WKUserScript(source: scriptContent, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
//                webView.configuration.userContentController.addUserScript(script)
//                webView.loadHTMLString(iframString, baseURL: nil)
//            }
//            
//        } catch {
//            
//        }
        webView = WKWebView(frame: CGRect(x: 0.0, y: navigationView.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height))
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        

       
        
        self.view.addSubview(webView)

        
        
        
        
        
    }
    

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        //webView.frame = CGRectMake(0.0, 0.0, webView.bounds.width, webView.scrollView.contentSize.height)
    }
    
    @IBAction func BacktoTheHomePage() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
