//
//  MenuTableViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/8/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath[1] == 0
        {
            performSegue(withIdentifier: "MenuHomeSegue", sender: self)
        }
        else if indexPath[1] == 1
        {
            if(loginuser.isLogin){
                performSegue(withIdentifier: "MenuProgressSegue", sender: self)
            }
            else{
                performSegue(withIdentifier: "MenuAccountSegue", sender: self)
            }
        }
        else if indexPath[1] == 2
        {
            if(loginuser.isLogin){
                performSegue(withIdentifier: "MenuCaseSelectSegue", sender: self)
            }
            else{
                performSegue(withIdentifier: "MenuAccountSegue", sender: self)
            }
        }
        else if indexPath[1] == 3
        {
            performSegue(withIdentifier: "MenuAccountSegue", sender: self)
        }
        else if indexPath[1] == 4
        {
            if(loginuser.isLogin){
                performSegue(withIdentifier: "MenuDiscussionSegue", sender: self)
            }
            else{
                performSegue(withIdentifier: "MenuAccountSegue", sender: self)
            }
        }
        else if indexPath[1] == 5
        {
            performSegue(withIdentifier: "MenuTeamSegue", sender: self)
        }
        else if indexPath[1] == 6
        {
            performSegue(withIdentifier: "MenuAboutSegue", sender: self)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
