//
//  InfoViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/5/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class InfoViewController: UIViewController
{
    @IBOutlet var password: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var privateKey: UITextField!
    @IBOutlet var seed: UITextField!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func Reveal()
    {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        request.returnsObjectsAsFaults = false
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if password.text == data.value(forKey: "password") as? String
                {
                    address.text = data.value(forKey: "address") as? String
                    privateKey.text = data.value(forKey: "privatekey") as? String
                    seed.text = data.value(forKey: "seed") as? String
                }
                else if address.text == ""
                {
                    let alert = UIAlertController(title: "Incrorrect Password", message: "" , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        } catch {
            
            print("Failed")
        }
    }
    @IBAction func ResignResponders()
    {
        password.resignFirstResponder()
        
    }
    @IBAction func GotoDashboard()
    {
        if let url = URL(string: "https://app.simbachain.com/") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    @IBAction func GotoSource()
    {
        if let url = URL(string: "https://www.rinkeby.io/#faucet") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    @IBAction func GotoDocs()
    {
        if let url = URL(string: "https://www.rinkeby.io/#faucet") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    @IBAction func GotoContact()
    {
        if let url = URL(string: "https://simbachain.com/contact/") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
}
