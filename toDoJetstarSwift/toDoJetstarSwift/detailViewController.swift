//
//  detailViewController.swift
//  toDoJetstarSwift
//
//  Created by Hrishav on 18/11/21.
//

import UIKit

class detailViewController: UIViewController {

    var labelDetail:String = ""
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = labelDetail
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
