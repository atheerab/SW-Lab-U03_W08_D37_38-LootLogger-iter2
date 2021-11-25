//
//  ViewController.swift
//  LootLogger-ATHEER
//
//  Created by Atheer abdullah on 11/04/1443 AH.
//

import UIKit

class ItemsViewController: UITableViewController {
  
  var itemStore: ItemStore!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 65
  }
  
  @IBAction func addNewItem(_ sender: UIButton) {
    

     let newItem = itemStore.createItem()
    
    if let index = itemStore.allItems.firstIndex(of: newItem) {
         let indexPath = IndexPath(row: index, section: 0)

         tableView.insertRows(at: [indexPath], with: .automatic)
  }
  }
  
  
  @IBAction func toggleEditingMode(_ sender: UIButton) {
    
    
       if isEditing {
           sender.setTitle("Edit", for: .normal)
           setEditing(false, animated: true)
       } else {
           sender.setTitle("Done", for: .normal)
           setEditing(true, animated: true)
       }
   }
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }

   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return itemStore.allItems.count
   }
   
  override func tableView(_ tableView: UITableView,
                           cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
    
       let item = itemStore.allItems[indexPath.row]
    
     cell.namelabel?.text = item.name
    cell.serialNumberLabel.text = item.serialNumber
    cell.valueinDollersLabel.text =
"$\(item.valueInDollars)"
    cell.valueinDollersLabel.textColor =
      item.valueInDollars > 50 ? .systemRed :
      .systemGreen
    
    let items: [Item]
    switch indexPath.section {
    case 0:
      items = itemStore.allItems
    default:
      items = itemStore.allItems
    }
     return cell
   }
  
  override func tableView(_ tableView: UITableView,
                          commit editingStyle: UITableViewCell.EditingStyle,
                          forRowAt indexPath: IndexPath) {
      // If the table view is asking to commit a delete command...
      if editingStyle == .delete {
          let item = itemStore.allItems[indexPath.row]
          // Remove the item from the store
          itemStore.removeItem(item)
          // Also remove that row from the table view with an animation
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
  }
  override func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
     // Update the model
  to destinationIndexPath: IndexPath) {
      itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
  
   
 }

