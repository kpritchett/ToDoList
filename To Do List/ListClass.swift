//
//  ListClass.swift
//  To Do List
//
//  Created by Student on 11/29/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ListClass: NSObject, NSCoding
{
    var listName = ""
    var stepOne = ""
    var stepTwo = ""
    var stepThree = ""
    var stepFour = ""
    var stepFive = ""
    
    init(Name : String, One : String, Two : String, Three : String, Four : String, Five : String)
    {
        super.init()
        listName = Name
        stepOne = One
        stepTwo = Two
        stepThree = Three
        stepFour = Four
        stepFive = Five
    }
    required init?(coder aDecoder : NSCoder)
    {
        listName = aDecoder.decodeObject(forKey: "listName") as! String
        stepOne = aDecoder.decodeObject(forKey: "stepOne") as! String
        stepTwo = aDecoder.decodeObject(forKey: "stepTwo") as! String
        stepThree = aDecoder.decodeObject(forKey: "stepThree") as! String
        stepFour = aDecoder.decodeObject(forKey: "stepFour") as! String
        stepFive = aDecoder.decodeObject(forKey: "stepFive") as! String
    }
    
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(listName, forKey: "listName")
        aCoder.encode(stepOne, forKey: "stepOne")
        aCoder.encode(stepTwo, forKey: "stepTwo")
        aCoder.encode(stepThree, forKey: "stepThree")
        aCoder.encode(stepFour, forKey: "stepFour")
        aCoder.encode(stepFive, forKey: "stepFive")
        
    }
}
