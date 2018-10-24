//
//  RegTableViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/10/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit
import Alamofire
class AuditTableViewController: UITableViewController {
    
    @IBOutlet var reverse: UIButton!
    
    var SIMBADataArray = [GetRegModel]()
    var hashLastTen = [GetRegModel]().suffix(10)
    
    var accountSelected: String! = ""
    var accountName: String! = ""
    var SIMBACode : Int!
    var reversed: Bool! = false
    var ten: Int!
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewdidappear")
        super.viewDidAppear(animated)

        
        DefaultAPI.getSIMBAData { (GetRegModel, error) in
            print("defaultapi.getsimbadata")
            if let SIMBAData = GetRegModel{
                print("SIMBA DATA")
                print(SIMBAData.first!.encodeToJSON())
            }
            if GetRegModel != nil
            {
                self.SIMBADataArray = GetRegModel!
                self.hashLastTen = GetRegModel!.suffix(10)
                self.ten = self.SIMBADataArray.count - 10
                self.tableView.reloadData()
                
            }
            else
            {
                let alert = UIAlertController(title: "Could not contact server", message: "check connection and try again.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    self.dismiss(animated: true)
                }))
                
                self.present(alert, animated: true)
                return
            }
        }
        
        
        
        
        
    }
    
    // MARK: Segue
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is DetailViewController
        {
            let vc = segue.destination as? DetailViewController
            vc?.accountSelected = accountSelected
            vc?.accountName = accountName
        }
        
        let ten = SIMBADataArray.count - 10
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = hashLastTen[indexPath.row + ten].hashId!
                
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }*/
    
    //---------------------
    //-----TABLEVIEW
    //---------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashLastTen.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
        
        if reversed == false
        {
            
          //  let currentSIMBAData = hashLastTen[indexPath.row + ten]
            let currentSIMBAData = hashLastTen[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
            print("currentSIMBAData")
            print(currentSIMBAData)
            cell.auditNoLabel.text  = " Audit No. \(String(describing: currentSIMBAData.id!))"
            cell.posterIDLabel.text = "Poster No. \(currentSIMBAData.make!)"
        }
        else
        {
            
            
            // let ten = SIMBADataArray.count + 10
            let currentSIMBAData = self.hashLastTen[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
            cell.auditNoLabel.text  = " Audit No. \(String(describing: currentSIMBAData.id!))"
            cell.posterIDLabel.text = "Poster No. \(currentSIMBAData.make!)"
            
            
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    @IBAction func cancelViewController()
    {
        dismiss(animated: true)
    }
    
    @IBAction func reverseOrder()
    {
        reverse.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.reverse.isEnabled = true
            if self.reversed == false
            {
                self.hashLastTen = ArraySlice(self.hashLastTen.reversed())
                self.reversed = !self.reversed
                self.tableView.reloadData()
            }
            else
            {
                
                self.reversed = !self.reversed
                self.viewDidAppear(false)
                
                
            }
            
            
        }
    }
}

class SIMBADataCell: UITableViewCell {
    
    @IBOutlet weak var auditNoLabel: UILabel!
    @IBOutlet weak var posterIDLabel: UILabel!
}


