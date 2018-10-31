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
    var hashem: [NSDictionary] = []
    
    var selectedDict : NSDictionary = [:]
    override func viewDidAppear(_ animated: Bool) {
        print("viewdidappear")
        super.viewDidAppear(animated)
  
        self.tableView.delegate = self
        self.tableView.dataSource = self
 
        
        DefaultAPI.getSIMBAData { (GetRegModel, error) in
          
            if GetRegModel != nil{
               
                
            }
            if GetRegModel != nil
            {
                self.SIMBADataArray = GetRegModel!
                self.hashLastTen = GetRegModel!.suffix(10)
                
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
       
        
                if let indexPath = tableView.indexPathForSelectedRow {
                    print("Did select row")
                    print("Row \(indexPath.row)selected")
                    selectedDict = self.hashem[indexPath.row]
                let vc = segue.destination as! DetailViewController
                vc.dict = selectedDict as NSDictionary
                print(vc.dict)
            }
        
 
    }
    //FILTER
    @IBAction func filter()
    {
    let alert = UIAlertController(title: "Filter", message: nil, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    alert.addTextField(configurationHandler: { textField in
    textField.placeholder = "Filter Records by Car Make"
    })
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
    
    if let make = alert.textFields?.first?.text {
    print("Your make: \(make)")
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
        
        if reversed == false
        {
            
          //  let currentSIMBAData = hashLastTen[indexPath.row + ten]
            let currentSIMBAData = hashem[indexPath.row]
            let currentpayload = currentSIMBAData["payload"] as! NSDictionary
            let currentinputs = currentpayload["inputs"] as! NSDictionary
            
            cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
          
            cell.IDLabel.text  = " ID: \((indexPath.row + 1))"
            cell.MakeLabel.text = "Make: \(currentinputs["Make"]!)"
            cell.ModelLabel.text = "Model: \(currentinputs["Model"]!)"
            cell.VinLabel.text = "VIN: \(currentinputs["VIN"]!)"
        }
        else
        {
            
            
            // let ten = SIMBADataArray.count + 10
            let currentSIMBAData = self.hashLastTen[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "SIMBADataCell") as! SIMBADataCell
            cell.IDLabel.text  = "ID: \(String(describing: currentSIMBAData.count!))"
            cell.MakeLabel.text = "Make: \(currentSIMBAData.make!)"
            cell.ModelLabel.text = "Model: \(currentSIMBAData.model!)"
            cell.VinLabel.text = "VIN: \(currentSIMBAData.vin!)"
            
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
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
    
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var MakeLabel: UILabel!
    @IBOutlet weak var ModelLabel: UILabel!
    @IBOutlet weak var VinLabel: UILabel!
}
