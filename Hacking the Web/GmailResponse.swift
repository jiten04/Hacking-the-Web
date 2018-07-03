//
//  GmailResponse.swift
//  Hacking the Web
//
//  Created by Victor S Melo on 03/07/18.
//  Copyright © 2018 Victor Melo. All rights reserved.
//

import Foundation
import SwiftSoup

enum HTMLError: Error {
    case badInnerHTML
}

struct GmailResponse {
    
    let authorContainerDivClass = "Yg Vl"
    let titleContainerDivClass = " Yg Wl"
    
    let emails: [Email]
    
    init(_ innerHTML: Any?) throws {
        guard let htmlString = innerHTML as? String else {
            throw HTMLError.badInnerHTML
        }
        let doc = try SwiftSoup.parse(htmlString)
        let authors = try doc.getElementsByClass("\(authorContainerDivClass)").array()
        let titles = try doc.getElementsByClass("\(titleContainerDivClass)").array()
        
        var emails = [Email]()
        for i in 0 ..< titles.count {
            let author = try authors[i].text()
            let title = try titles[i].text()
            
            print(author)
            print(title)
            print("")
            
            let email = Email(author: author, title: title)
            emails.append(email)
        }
        self.emails = emails
    }
}
