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
    //in this view all posted transactions are displayed in a list
    @IBOutlet var reverse: UIButton!
    
    var SIMBADataArray = [GetRegModel]()
    var hashLastTen = [GetRegModel]().suffix(10)
    
    
    var accountSelected: String! = ""
    var accountName: String! = ""
    var SIMBACode : Int!
    var reversed: Bool! = false
    var ten: Int!
    var hashem: [NSDictionary] = []
    
    var selectedDict : NSDictionary = [:]
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //get all the data
        DefaultAPI.getSIMBAData { (GetRegModel, error) in
            
            if GetRegModel != nil{
                
                
            }
            if GetRegModel != nil
            {
                self.SIMBADataArray = GetRegModel!
                self.hashLastTen = GetRegModel!.suffix(10)
                //hashem is where all the transactions are stored
                self.hashem = self.hashLastTen[0].results!
                self.ten = self.hashem.count - 10
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Did select row")
        print("Row \(indexPath.row)selected")
        selectedDict = self.hashem[indexPath.row] 
        //    selectedLabel = self.tableData[indexPath.row]
        performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        
        //passes off the data of the selected transaction to the detail view
        if let indexPath = tableView.indexPathForSelectedRow {
            print("Did select row")
            print("Row \(indexPath.row)selected")
            selectedDict = self.hashem[indexPath.row]
            let vc = segue.destination as! DetailViewController
            vc.dict = selectedDict as NSDictionary
            print(vc.dict)
        }
        
        
    }
    //FILTERED GET
    @IBAction func filter()
    {
        //pretty much the same thing as in view did appear but runs a filtered get command instead of getting all data
        let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Filter Records by Car Make"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let make = alert.textFields?.first?.text {
                
                DefaultAPI.getFilteredSIMBAData(filter: make) { (GetRegModel, error) in
                    print("defaultapi.getsimbadata")
                    if let SIMBAData = GetRegModel{
                        print("SIMBA DATA")
                        print(SIMBAData.first!.encodeToJSON())
                        
                    }
                    if GetRegModel != nil
                    {
                        self.SIMBADataArray = GetRegModel!
                        self.hashLastTen = GetRegModel!.suffix(10)
                        
                        self.hashem = self.hashLastTen[0].results ?? []
                        self.ten = self.hashem.count - 10
                        print("hashem")
                        print(self.hashem)
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
        }))
        
        self.present(alert, animated: true)
        //END OF FILTERED DATA FUNCTION
    }
    
    //---------------------
    //-----TABLEVIEW
    //---------------------
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hashem.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
        //  Displays the data inside of the cells
        let currentSIMBAData = hashem[indexPath.row]
        let currentpayload = currentSIMBAData["payload"] as! NSDictionary
        let currentinputs = currentpayload["inputs"] as! NSDictionary
        
        cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
        
        cell.IDLabel.text  = " ID: \((indexPath.row + 1))"
        cell.MakeLabel.text = "Make: \(currentinputs["Make"]!)"
        cell.ModelLabel.text = "Model: \(currentinputs["Model"]!)"
        cell.VinLabel.text = "VIN: \(currentinputs["VIN"]!)"
        
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    
}

class SIMBADataCell: UITableViewCell {
    //this defines all the outlets inside of the prototype cell
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var MakeLabel: UILabel!
    @IBOutlet weak var ModelLabel: UILabel!
    @IBOutlet weak var VinLabel: UILabel!
}
