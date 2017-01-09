//
//  ViewController.swift
//  To Do List
//
//  Created by Student on 11/28/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    var lists : [ListClass] = []
    var indexLoc = 0
    let defaults = UserDefaults.standard
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //adds lists to the array of lists
        lists.append(ListClass(Name: "Getting Ready For School", One: "WAKE UP", Two: "Grab Some Clothes", Three: "Take a Shower", Four: "Eat Breakfast", Five: "Get in Car and Drive to School"))
        lists.append(ListClass(Name: "Writing an Essay", One: "Sit Down at Desk", Two: "Creat Word Document", Three: "Get Distracted, Go on Reddit and Play Video Games for 3 Hours", Four: "Panic Because it's 11 o'clock", Five: "Write the Entire Essay"))
        
        
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell: AnyObject = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
            cell.textLabel!?.text = lists[indexPath.row].listName
            indexLoc = indexPath.row
            return cell as! UITableViewCell
            //pulls out data from disk
            
            print("WORKS")
        }
        func save()
        {
            //NSKeyedArchiver convert our array into a data object
            for i in 0 ..< lists.count + 1
            {
                let savedData = NSKeyedArchiver.archivedData(withRootObject: lists[i])
                let defaults = UserDefaults.standard
                defaults.set(savedData, forKey: "list")
            }
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return lists.count
        }
        
        func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
        {
            if editingStyle == .delete
            {
                lists.remove(at: indexPath.row)
                myTableView.reloadData()
            }
        }
        
        
    @IBAction func addButtonTapped(sender: AnyObject)
        {
            //creates alert view that allows the user to add a new list
            let myAlert = UIAlertController(title: "Add List, List in Order of Most to Least Urgent.", message: nil, preferredStyle: .alert)
            myAlert.addTextField{ (nameTextField) -> Void in
                nameTextField.placeholder = "List Name Here"
            }
            myAlert.addTextField{ (stepOneTextField) -> Void in
                stepOneTextField.placeholder = "Add Step 1"
            }
            myAlert.addTextField{ (stepTwoTextField) -> Void in
                stepTwoTextField.placeholder = "Add Step 2"
            }
            myAlert.addTextField{ (stepThreeTextField) -> Void in
                stepThreeTextField.placeholder = "Add Step 3"
            }
            myAlert.addTextField{ (stepFourTextField) -> Void in
                stepFourTextField.placeholder = "Add Step 4"
            }
            myAlert.addTextField{ (stepFiveTextField) -> Void in
                stepFiveTextField.placeholder = "Add Step 5"
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            myAlert.addAction(cancelAction)
            let addAction = UIAlertAction(title: "Add", style: .default) { (addAction) -> Void in
                let nameTF = myAlert.textFields![0]
                let stepOneTF = myAlert.textFields![1]
                let stepTwoTF = myAlert.textFields![2]
                let stepThreeTF = myAlert.textFields![3]
                let stepFourTF = myAlert.textFields![4]
                let stepFiveTF = myAlert.textFields![5]
                
                self.lists.append(ListClass(Name: nameTF.text!, One: stepOneTF.text!, Two: stepTwoTF.text!, Three: stepThreeTF.text!, Four: stepFourTF.text!, Five: stepFiveTF.text!))
                self.myTableView.reloadData()
            }
            myAlert.addAction(addAction)
            self.present(myAlert, animated: true, completion: nil)
        }
        
        @IBAction func editButtonTapped(_ sender: AnyObject)
        {
            if editButton.tag == 0
            {
                myTableView.isEditing = true
                editButton.tag = 1
            }
            else
            {
                myTableView.isEditing = false
            }
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            //segue stuff
            for i in 0 ..< 2
            {
                if let savedList = defaults.object(forKey: "list")! as? Data
                {
                    lists[i] = NSKeyedUnarchiver.unarchiveObject(with: savedList)! as! ListClass
                    //converts data back into an object
                }
            }
            let blueList = segue.destination as! SecondViewController
            let selectedRow = self.myTableView.indexPathForSelectedRow!.row
            blueList.indexPlace = self.indexLoc
            blueList.list = self.lists[selectedRow]
            blueList.listed = self.lists
            
        }
}

