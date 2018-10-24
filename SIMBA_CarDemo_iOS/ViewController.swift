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
            ethBalance.isHidden = false
            getEth.isHidden = false
            balLabel.isHidden = false
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
            ethBalance.isHidden = true
            getEth.isHidden = true
            balLabel.isHidden = true
            addressLabel.isHidden = true
        }
        
        
        let configuration = Configuration(
            network: .private(chainID: 4, testUse: false),
            nodeEndpoint: "http://api-rinkeby.etherscan.io/api?",
            etherscanAPIKey: "8TZXFHXHCEBNSMQZDP64NKS8R4SDHVNWSF",
            debugPrints: true
        )
        
        let geth = Geth(configuration: configuration)
        
        // To get a balance of an address, call `getBalance`.
        geth.getBalance(of: address.text!) { _ in 
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
