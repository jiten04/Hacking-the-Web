//
//  ViewController.swift
//  Hacking the Web
//
//  Created by Victor S Melo on 03/07/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let emailInputId = "Email"
    let passwordInputId = "Passwd"
    let loginFormId = "gaia_loginform"
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let webView = WKWebView()
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://www.gmail.com")!
        let request = URLRequest(url: url)
        webView.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        webView.load(request)
        view.addSubview(webView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let emails = sender as AnyObject as? [Email],
            let emailsVC = segue.destination as? EmailsVC else { return }
        
        emailsVC.emails = emails
    }

    @IBAction func onSignInTapped() {
        switch counter {
        case 0:
            webView.evaluateJavaScript("document.getElementById('\(emailInputId)').value='\(emailTF.text!)';", completionHandler: nil)
        case 1:
            webView.evaluateJavaScript("document.getElementById('\(loginFormId)').submit();", completionHandler: nil)
        case 2:
            webView.evaluateJavaScript("document.getElementById('\(passwordInputId)').value='\(passwordTF.text!)';", completionHandler: nil)
        case 3:
            webView.evaluateJavaScript("document.getElementById('\(loginFormId)').submit();", completionHandler: nil)
        case 4:
            webView.reload()
        default:
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (innerHTML, error) in
                do {
                    let gmailResponse = try GmailResponse(innerHTML)
                    self.performSegue(withIdentifier: "ShowEmails", sender: gmailResponse.emails)
                } catch {}
            }
        }
        counter += 1
    }
    
}

