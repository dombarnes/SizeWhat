//
//  ItemTableViewController.swift
//  SizeWhat
//
//  Created by Dominic Barnes on 08/12/2016.
//  Copyright © 2016 Trilby Multimedia Limited. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    // MARK: Properties
  
    var items = [Item]()
  
    override func viewDidLoad() {
      super.viewDidLoad()

      loadSampleItems()
    }

    func loadSampleItems() {
      let photo1 = UIImage(named: "defaultPhoto")!
      let item1 = Item(name: "Item 1", description: "", type: "", roomName: "Lounge", photo: photo1, rating: 1)!
      let item2 = Item(name: "Item 2", description: "", type: "", roomName: "Kitchen", photo: photo1, rating: 3)!
      let item3 = Item(name: "Item 3", description: "", type: "", roomName: "Kitchen", photo: photo1, rating: 5)!
      
      items += [item1, item2, item3]
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cellIdentifier = "ItemTableViewCell"
      let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ItemTableViewCell
      
      let item = items[indexPath.row]
      
      cell.nameLabel.text = item.name
      cell.ratingControl.rating = item.rating
      cell.photoImageView.image = item.photo
      
      return cell
    }
 

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
