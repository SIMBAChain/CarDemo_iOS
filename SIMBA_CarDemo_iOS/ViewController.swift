//
//  ViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 9/26/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import UIKit
import EthereumKit
import CoreData
import Alamofire
class ViewController: UIViewController {
    @IBOutlet var address: UITextField!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var ethBalance: UITextField!
    @IBOutlet var getButton: UIButton!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var importButton: UIButton!
    @IBOutlet var switchButton: UIButton!
    @IBOutlet var notifLabel:UILabel!
    @IBOutlet var getEth:UIButton!
    @IBOutlet var balLabel: UILabel!
    @IBOutlet var addresslabel: UILabel!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   

    override func viewDidLoad() {
        super.viewDidLoad()
       
     
}

    override func viewDidAppear(_ animated: Bool) {
        print("View Did Appear")
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        request.returnsObjectsAsFaults = false
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                address.text = data.value(forKey: "address") as? String
                
            }
            
        } catch {
            
            print("Failed")
        }
        //Gets balance
        if address.text != ""
        {
        Alamofire.request(("https://api-rinkeby.etherscan.io/api?module=account&action=balance&address=" + address.text! + "&tag=latest&apikey=8TZXFHXHCEBNSMQZDP64NKS8R4SDHVNWSF")).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = (response.result.value) {
                print("JSON: \(json)") // serialized json response
                let dict = json as! NSDictionary
                let resultString = dict["result"] as! String
                if let resultDouble = Double(resultString) {
                    if resultDouble <= 0
                    {
                        let alertVC = UIAlertController(
                            title: "No Ethereum",
                            message: "To Post or Get you need ETH" ,
                            preferredStyle: .alert)
                        let okAction = UIAlertAction(
                            title: "OK",
                            style:.default,
                            handler: nil)
                        alertVC.addAction(okAction)
                        self.present(alertVC,animated: true,completion: nil)
                        
                        
                        self.ethBalance.text = "0"
                        self.switchButton.isHidden = false
                        self.getButton.isHidden = true
                        self.postButton.isHidden = true
                        self.createButton.isHidden = true
                        self.importButton.isHidden = true
                        self.notifLabel.isHidden = true
                        self.address.isHidden = false
                        self.addressLabel.isHidden = false
                        self.getEth.isHidden = false
                        self.balLabel.isHidden = false
                        self.ethBalance.isHidden = false
                        self.addressLabel.isHidden = false
                        return
                    }
                    self.ethBalance.text = String(resultDouble / 1000000000000000000)
                }
                
                
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            
        }
        }
        if address.text != ""
        {
            switchButton.isHidden = false
            getButton.isHidden = false
            postButton.isHidden = false
            createButton.isHidden = true
            importButton.isHidden = true
            notifLabel.isHidden = true
            address.isHidden = false
            addressLabel.isHidden = false
            getEth.isHidden = false
            balLabel.isHidden = false
            ethBalance.isHidden = false
            addressLabel.isHidden = false
        }
        else{
            switchButton.isHidden = true
            getButton.isHidden = true
            postButton.isHidden = true
            createButton.isHidden = false
            importButton.isHidden = false
            notifLabel.isHidden = false
            address.isHidden = true
            addressLabel.isHidden = true
            getEth.isHidden = true
            balLabel.isHidden = true
            ethBalance.isHidden = true
            addressLabel.isHidden = true
        }
        
    }
    
    @IBAction func SwitchAccount()
    {
    createButton.isHidden = !createButton.isHidden
    importButton.isHidden = !importButton.isHidden
        let alert = UIAlertController(title: "Switching wallets will remove the currently stored wallet", message: "note: your current wallet can be restored with your 12 words" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    @IBAction func GetETH()
    {
        if let url = URL(string: "https://www.rinkeby.io/#faucet") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
}
