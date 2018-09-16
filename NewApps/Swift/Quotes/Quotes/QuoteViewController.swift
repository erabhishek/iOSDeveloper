//
//  ViewController.swift
//  Quotes
//
//  Created by Abhishek Sharma on 15/09/18.
//  Copyright © 2018 Abhishek Sharma. All rights reserved.
//

import UIKit

class QuoteViewController : UIViewController , UITableViewDelegate, UITableViewDataSource {

    
//    var quotesDict =  NSDictionary()
    let QuoteAuthors = [String]() // = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
    var quoteObject = Quote()
    
    
    
    var quoteWrittenby = String()
    var quoteImage = String()
    var quoteText = String()
    
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quotes"
        
        if let path = Bundle.main.path(forResource: "Quotes", ofType: "plist"),
            let myDict = NSDictionary(contentsOfFile: path){
            quoteObject = Quote(quotes: myDict)
//            self.quotesDict = myDict
            // Use your myDict here
//            print("myDict \(myDict)");
//            print("Quotes \(myDict["Quotes"])");
//            var QuotesList  : NSArray  = myDict["Quotes"] as! NSArray
//            print("QuotesList \(QuotesList[0])");
//            print("QuotesList \(QuotesList)");
//            var QuotesDetails  : NSDictionary  = QuotesList[0] as! NSDictionary
//            print("QuotesDetails \(QuotesDetails)");
////            var QuotesDetails  : NSDictionary  = QuotesList[0] as! NSDictionary
//            print("QuotesDetails \(QuotesDetails["QuoteList"])");
//            print("QuoteType \(QuotesDetails["QuoteType"])");
//
//            var QuoteList  : NSArray  = QuotesDetails["QuoteList"] as! NSArray
//            print("Final Quotes Details \(QuoteList[0])");
//
//            var finalQuotes  : NSDictionary  = QuoteList[0] as! NSDictionary
//
//            print("Final Quotes image \(finalQuotes["image"] as! String)");
//
//            print("Final Quotes text \(finalQuotes["text"] as! String)");
//
//            print("Final Quotes writtenby \(finalQuotes["writtenby"] as! String)");

        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quoteObject.quotesList.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return quoteObject.quotesAuthor(atSection: section)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteObject.quotesForAuthor(atSection: section)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)
        
         cell?.textLabel?.text = "\(indexPath.row)"
//        cell.myView.backgroundColor = self.colors[indexPath.row]
//        cell.myCellLabel.text = self.animals[indexPath.row]
        
        return cell!
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        self.quoteWrittenby = quoteObject.quotesWrittenby(atSection: indexPath.section, atIndex: indexPath.row)
        self.quoteImage = quoteObject.quotesImage(atSection: indexPath.section, atIndex: indexPath.row)
        self.quoteText = quoteObject.quotesText(atSection: indexPath.section, atIndex: indexPath.row)
        self.performSegue(withIdentifier: "quoteDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quoteDetails"
        {
            let controller = segue.destination as! QuoteDetailViewController
            controller.quoteWrittenby = self.quoteWrittenby
            controller.quoteImage = self.quoteImage
            controller.quoteText = self.quoteText
        }
    }
}

