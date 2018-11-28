//
//  DetailViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/30/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController
{
    //Outlets
    @IBOutlet  var make: UITextField!
    @IBOutlet  var model: UITextField!
    @IBOutlet  var vin: UITextField!
    @IBOutlet  var ipfs: UITextField!
    @IBOutlet  var imgName: UILabel!
    @IBOutlet  var imgSize: UILabel!
    @IBOutlet  var imgView: UIImageView!
    var dict : NSDictionary!
    var currentRaw = [:] as NSDictionary
    //variables
    let mainVC = ViewController()
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    func configureView()
    {
        // Update the user interface for the detail item.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        print("DETAIL VIEW")
        print(dict)
        let currentPayload = dict["payload"] as! NSDictionary
        let currentInputs = currentPayload["inputs"] as! NSDictionary
         self.currentRaw = currentPayload["raw"] as! NSDictionary
        make.text = (currentInputs["Make"] as! String)
        model.text = (currentInputs["Model"] as! String)
        vin.text = (currentInputs["VIN"] as! String)
        //getting the image
        let id = dict["id"] as! String
        DefaultAPI.getSIMBADataImage(txn_id: id) { (GetRegModel, error) in
            
          
            if GetRegModel != nil
            {
                self.ipfs.text = GetRegModel?.first?.bundle_hash
                
                let manifest = GetRegModel?.first?.manifest
                let manifestDict:NSDictionary = manifest![0] as! NSDictionary
                let imageBase64 = manifestDict["data"] as! String
                
                let dataDecoded : Data = Data(base64Encoded: imageBase64)!
                let decodedimage = UIImage(data: dataDecoded)
                self.imgName.text = "Image Name: " + (manifestDict["name"] as! String)
                self.imgSize.text = "Image Size: " + String(manifestDict["size"] as! Double) + " bytes"
                self.imgView.image = decodedimage
            }
            
        }
      
        
      
        
        
    }

    @IBAction func TranInfo()
    {
        let alertMessage = "Transaction Hash:" + String(currentRaw["data"] as! String) + "\nTransaction From:" + String(currentRaw["from"] as! String)
        let alertMessage2 = "\nTransaction To:" + String(currentRaw["to"] as! String) + "\nTransaction Status:" + String(dict["status"] as! String) + "\nGas Used:" + String(currentRaw["gas"] as! Double)
        let alertVC = UIAlertController(
            title: "Transaction Information",
            message: alertMessage + alertMessage2 ,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    

    

}
