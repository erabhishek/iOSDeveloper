//
//  ViewController.swift
//  Quotes
//
//  Created by Abhishek Sharma on 15/09/18.
//  Copyright © 2018 Abhishek Sharma. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    // These are the colors of the square views in our table view cells.
    // In a real project you might use UIImages.
    let colors = [UIColor.blue, UIColor.yellow, UIColor.magenta, UIColor.red, UIColor.brown]
    
    // Don't forget to enter this in IB also
    let cellReuseIdentifier = "cell"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quotes"
        
        if let path = Bundle.main.path(forResource: "Quotes", ofType: "plist"),
            let myDict = NSDictionary(contentsOfFile: path){
            // Use your myDict here
            print("myDict \(myDict)");
            print("Quotes \(myDict["Quotes"])");
            var QuotesList  : NSArray  = myDict["Quotes"] as! NSArray
            print("QuotesList \(QuotesList[0])");
            print("QuotesList \(QuotesList)");
            var QuotesDetails  : NSDictionary  = QuotesList[0] as! NSDictionary
            print("QuotesDetails \(QuotesDetails)");
//            var QuotesDetails  : NSDictionary  = QuotesList[0] as! NSDictionary
            print("QuotesDetails \(QuotesDetails["QuoteList"])");
            print("QuoteType \(QuotesDetails["QuoteType"])");

            var QuoteList  : NSArray  = QuotesDetails["QuoteList"] as! NSArray
            print("Final Quotes Details \(QuoteList[0])");

            var finalQuotes  : NSDictionary  = QuoteList[0] as! NSDictionary
            
            print("Final Quotes image \(finalQuotes["image"] as! String)");
            
            print("Final Quotes text \(finalQuotes["text"] as! String)");
            
            print("Final Quotes writtenby \(finalQuotes["writtenby"] as! String)");

        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.animals.count
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
    }
}

