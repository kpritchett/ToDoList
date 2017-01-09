//
//  SecondViewController.swift
//  To Do List
//
//  Created by Student on 12/1/16.
//  Copyright © 2016 Student. All rights reserved.
//

import UIKit
class SecondViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate
{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    var list : ListClass!
    var indexPlace = 0
    var steps : [String] = []
    var listed : [ListClass] = []
    var i = Int()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        titleLabel.text = list.listName
        //sets list parameters to parts of the steps array
        steps.append(list.stepOne)
        steps.append(list.stepTwo)
        steps.append(list.stepThree)
        steps.append(list.stepFour)
        steps.append(list.stepFive)
        myTableView.isEditing = true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: AnyObject = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        //sets the text of each cell based off of the number of the step
        if steps[indexPath.row] == "Completed"
        {
            cell.textLabel??.text = "Completed"
        }
        else if steps[indexPath.row] == list.stepOne
        {
            cell.textLabel??.text = "1: " + steps[indexPath.row]
        }
        else if steps[indexPath.row] == list.stepTwo
        {
            cell.textLabel??.text = "2: " + steps[indexPath.row]
        }
        else if steps[indexPath.row] == list.stepThree
        {
            cell.textLabel??.text = "3: " + steps[indexPath.row]
        }
        else if steps[indexPath.row] == list.stepFour
        {
            cell.textLabel??.text = "4: " + steps[indexPath.row]
        }
        else if steps[indexPath.row] == list.stepFive
        {
            cell.textLabel??.text = "5: " + steps[indexPath.row]
        }
        
        return cell as! UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return steps.count
    }
    func save()
    {
        //NSKeyedArchiver convert our array into a data object
        let savedData = NSKeyedArchiver.archivedData(withRootObject: list)
        
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "list")
    }
    
    func tableView(_ tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .delete
        {
            //sets cell text to blank
            if steps[indexPath.row] == list.stepOne
            {
                list.stepOne = "Completed"
            }
            else if steps[indexPath.row] == list.stepTwo
            {
                list.stepTwo = "Completed"
            }
            else if steps[indexPath.row] == list.stepThree
            {
                list.stepThree = "Completed"
            }
            else if steps[indexPath.row] == list.stepFour
            {
                list.stepFour = "Completed"
            }
            else if steps[indexPath.row] == list.stepFive
            {
                list.stepFive = "Completed"
            }
            steps.remove(at: indexPath.row)
            
            save()
            //sets this part of the array equal to the coinciding array in ViewController
            
            listed[indexPlace] = self.list
            
            myTableView.reloadData()
            
        }
    }
    
    

    @IBAction func editButtonTapped(_ sender: UIButton)
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
        let mainList = segue.destination as! ViewController
        mainList.lists = self.listed
        
    }
}
