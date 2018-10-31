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
        let currentpayload = dict["payload"] as! NSDictionary
        let currentinputs = currentpayload["inputs"] as! NSDictionary
        make.text = (currentinputs["Make"] as! String)
        model.text = (currentinputs["Model"] as! String)
        vin.text = (currentinputs["VIN"] as! String)
        //getting the image
        let id = dict["id"] as! String
        DefaultAPI.getSIMBADataImage(txn_id: id) { (GetRegModel, error) in
            print("defaultapi.getsimbadata")
            if let SIMBAData = GetRegModel{
                print("SIMBA DATA")
                print(SIMBAData.first!.encodeToJSON())
                
            }
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

 
    

    

}
