//
//  Quote.swift
//  Quotes
//
//  Created by Abhishek Sharma on 16/09/18.
//  Copyright © 2018 Abhishek Sharma. All rights reserved.
//

import UIKit

class Quote: NSObject {
    var quotesList  = NSArray()
    var finalQuotes  = NSDictionary()
    
    override init() {
        
    }
    init(quotes : NSDictionary) {
         quotesList = quotes["Quotes"] as! NSArray
    }
    
    func quotesAuthor(atSection : Int) -> String{
        let quotesDetails  : NSDictionary  = quotesList[atSection] as! NSDictionary
        return quotesDetails["QuoteType"] as! String
    }
    func quotesForAuthor(atSection : Int) -> Int{
      
        let quotesDetails  : NSDictionary  = quotesList[atSection] as! NSDictionary
        let quoteArray  : NSArray  = quotesDetails["QuoteList"] as! NSArray
        return quoteArray.count
    
    }
    
    
    func quotesText(atSection : Int , atIndex : Int) -> String{
        let quotesDetails  : NSDictionary  = quotesList[atSection] as! NSDictionary
         let quoteArray  : NSArray  = quotesDetails["QuoteList"] as! NSArray
        let finalQuotes  : NSDictionary  = quoteArray[atIndex] as! NSDictionary
        return finalQuotes["text"] as! String
    }

    func quotesImage(atSection : Int , atIndex : Int) -> String{
        let quotesDetails  : NSDictionary  = quotesList[atSection] as! NSDictionary
        let quoteArray  : NSArray  = quotesDetails["QuoteList"] as! NSArray
        let finalQuotes  : NSDictionary  = quoteArray[atIndex] as! NSDictionary
   return finalQuotes["image"] as! String
    }

    func quotesWrittenby(atSection : Int , atIndex : Int) -> String{
        let quotesDetails  : NSDictionary  = quotesList[atSection] as! NSDictionary
        let quoteArray  : NSArray  = quotesDetails["QuoteList"] as! NSArray
        let finalQuotes  : NSDictionary  = quoteArray[atIndex] as! NSDictionary
     return finalQuotes["writtenby"] as! String
    }
}
