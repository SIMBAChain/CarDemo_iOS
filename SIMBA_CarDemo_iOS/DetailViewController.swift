//
//  DetailViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/30/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
class DetailViewController: UIViewController
{
    //this is the view for viewing the details of a transaction such as the car photo
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
    var currentReceipt = [:] as NSDictionary
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
        self.currentReceipt = dict["receipt"] as! NSDictionary
        self.currentRaw = currentPayload["raw"] as! NSDictionary
        make.text = (currentInputs["Make"] as! String)
        model.text = (currentInputs["Model"] as! String)
        vin.text = (currentInputs["VIN"] as! String)
        //getting the image
        let id = dict["id"] as! String
        //gets the image based off the txn_id
        let headers: HTTPHeaders = ["APIKEY":"0ce2c6f644fa15bfb25520394392af4f835153a6be1beff0c096988d647a97c4"]
        //make the post request
        let url = URL(string: "https://api.simbachain.com/v1/ioscardemo2/transaction/" + id + "/file/0/")!
        print(url)
       
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("0ce2c6f644fa15bfb25520394392af4f835153a6be1beff0c096988d647a97c4", forHTTPHeaderField: "APIKEY")
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
            guard let data = data else { return }
           // print(String(data: data, encoding: .utf8)!)
            self.imgView.image = UIImage(data: data)
        }
        
    
       
        
       /* Alamofire.download(("https://api.simbachain.com/v1/ioscardemo2/transaction/" + id + "/file/0/"), method: .get, headers: headers).responseData { response in
            if let data = response.value {
                self.imgView.image = UIImage(data: data)
                
            }
            print(response.value)
        }*/
      /*  Alamofire.request(.GET, method: "https://robohash.org/123.png").response { (request, response, data, error) in
            self.imgView.image = UIImage(data: data, scale:1)
          }*/
        
     /*   DefaultAPI.getSIMBADataImage(txn_id: id) { (GetRegModel, error) in
            
            
            if GetRegModel != nil
            {
                //displays all the image variables
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
            
        }*/
        
        
        
        
        
    }
    
    @IBAction func TranInfo()
    {
        //puts all of the extra transaction info into an alert and displays it
        let alertMessage = "Transaction Hash:" + String(currentRaw["data"] as! String) + "\nTransaction From:" + String(currentRaw["from"] as! String)
        let alertMessage2 = "\nTransaction To:" + String(currentRaw["to"] as! String) + "\nTransaction Status:" + String(dict["status"] as! String) + "\nGas Used:" + String(currentReceipt["gasUsed"] as! Double)
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
