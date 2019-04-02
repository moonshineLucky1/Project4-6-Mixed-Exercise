//
//  FirstTableViewController.swift
//  day32-project4-6
//
//  Created by 李沐軒 on 2019/3/16.
//  Copyright © 2019 李沐軒. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    
    var shoppingList = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping list"
        
        let addButton: UIBarButtonItem
        let activityButton: UIBarButtonItem
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.rightBarButtonItem = addButton
        
        activityButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tapped))
        
        let deleteAllButton: UIBarButtonItem
        let undoButton: UIBarButtonItem
        
            deleteAllButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeItem))
        
        undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undoItem))
        
        navigationItem.leftBarButtonItems = [deleteAllButton, undoButton]
        
        navigationItem.rightBarButtonItems = [activityButton, addButton]

    }
    
    @objc func undoItem() {
        let ac = UIAlertController(title: "Nothing here.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if !(shoppingList.isEmpty) {
            shoppingList.remove(at: 0)
            tableView.reloadData()
        } else {
            present(ac, animated: true, completion: nil)
        }
    }
    
    @objc func removeItem() {
        let ac = UIAlertController(title: "It's empty.", message: "Nothing needs to delete.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if !(shoppingList.isEmpty) {
            shoppingList.removeAll()
            tableView.reloadData()
        } else {
            present(ac, animated: true, completion: nil)
        }
    }
  
    @objc func tapped() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @objc func addItem() {
        
        let ac = UIAlertController(title: "add an item", message: nil, preferredStyle: .alert)
            
            ac.addTextField(configurationHandler: nil)
            
            let submitAction = UIAlertAction(title: "Submit", style: .default) {
                [weak self, weak ac] (_) in
                guard let input = ac?.textFields?[0].text, case input.isEmpty = false else { return }
                
                self?.addIntoList(input)
            }

            ac.addAction(submitAction)
            present(ac, animated: true, completion: nil)

        }
        

    func addIntoList(_ input: String) {
        let lowerInput = input.lowercased()
        
        shoppingList.insert(lowerInput, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        return
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = shoppingList[indexPath.row]

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
