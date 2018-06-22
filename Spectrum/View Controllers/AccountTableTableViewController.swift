//
//  AccountTableTableViewController.swift
//  Spectrum
//
//  Created by Boning Liang on 3/3/18.
//  Copyright © 2018 Boning Liang. All rights reserved.
//

import UIKit
import CoreData

var isLogin:Bool = false
class AccountTableTableViewController: UITableViewController {

    @IBOutlet weak var loginORprofileCell: UITableViewCell!
    
    @IBOutlet weak var loginORprofileText: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(revealViewController().revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())

        if loginuser.isLogin {
            loginORprofileText.text = "Profile"
        }
        else{
            loginORprofileText.text = "Login"
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginuser.isLogin {
            loginORprofileText.text = "Profile"
        }
        else{
            loginORprofileText.text = "Login"
            self.tableView.reloadData()
        }
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
        if loginuser.isLogin{
            return 2
        }else{
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            if loginuser.isLogin {
                performSegue(withIdentifier: "profileSegue", sender: nil)
            }
            else{
                performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        if indexPath.row == 1{
            if loginuser.isLogin {
                // log out
                let fetchRequest: NSFetchRequest<LoginSessionEntity> = LoginSessionEntity.fetchRequest()
                var loginSessionResult = [LoginSessionEntity]()
                let context = CoreDataService.context
                var subPredicates = [NSPredicate]()
                let predicate = NSPredicate(format: "username == %@", loginuser.username!)
                subPredicates.append(predicate)
                if subPredicates.count>0 {
                    let compoundPredicates = NSCompoundPredicate.init(type: .and, subpredicates: subPredicates)
                    fetchRequest.predicate = compoundPredicates
                }
                do {
                    print("AccountTableTableViewController: tableView() update login session entity...")
                    loginSessionResult = try context.fetch(fetchRequest)
                }catch{
                    
                    print("AccountTableTableViewController: false 1")
                }
                if loginSessionResult.count>0{
                    let managedObject = loginSessionResult[0]
                    managedObject.setValue(false, forKey: "isLogin")
                    do{
                        try context.save()
                        print("AccountTableTableViewController(): update login session entity success")
                        // true
                    } catch{
                        print("AccountTableTableViewController(): false 1")
                        // false
                    }
                }
                
                
                loginuser.isLogin = false
                
                CoreDataService.saveContext()
                performSegue(withIdentifier: "loginSegue", sender: nil)
                
            }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
