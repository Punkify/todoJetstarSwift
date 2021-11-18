//
//  ViewController.swift
//  toDoJetstarSwift
//
//  Created by Hrishav on 18/11/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var addLabel: UILabel!
    
    @IBOutlet weak var editLabel: UILabel!
    
    var todoArray = [String]()
    
    var rowToEdit: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setUPTableView()
        
        tapHandler()
        
        
    }
    
  
    func setUPTableView() {
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
 
    
    func tapHandler(){
        let addTapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview))
        addLabel.addGestureRecognizer(addTapGesture)
        
        
    }
    
    @objc func didtapview(){
        
        let alert = UIAlertController(title: "Enter Your to do item", message: "", preferredStyle: .alert)

      
        alert.addTextField { (textField) in
            textField.text = ""
        }

        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let textValue = textField?.text
           
            self.todoArray.append(textValue!)
            UserDefaults.standard.set(self.todoArray, forKey: "Key")
            print("Text field: \(textValue)")
            print("arrays: \(self.todoArray)")
           
            self.myTableView.reloadData()
        }))

       
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func edittapview() -> Bool{
        
        return true
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let arrayOfText =  UserDefaults.standard.array(forKey: "Key")!
        print("The arrays of text are", arrayOfText)
        cell.textLabel?.text = arrayOfText[indexPath.row] as! String
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
        vc.labelDetail = todoArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        edittapview()
    }

     func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            let alert = UIAlertController(title: "", message: "Edit list item", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
            textField.text = self.todoArray[indexPath.row]
            })
            alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
                self.todoArray[indexPath.row] = alert.textFields!.first!.text!
                self.myTableView.reloadRows(at: [indexPath], with: .fade)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: false)
        })

        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.todoArray.remove(at: indexPath.row)
            tableView.reloadData()
        })

        return [deleteAction, editAction]
    }
}

