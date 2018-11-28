//
//  GenerateWalletViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 9/27/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation
import UIKit
import EthereumKit
import WebKit
import CoreData

import CryptoSwift
class GenerateWalletViewController: UIViewController {
   
    @IBOutlet var outSeed: UITextField!
    @IBOutlet var outAddress: UITextField!
    @IBOutlet var outPrivateKey: UITextField!
    @IBOutlet var genButton: UIButton!
    @IBOutlet var authButton: UIButton!
    @IBOutlet var pass: UITextField!
    @IBOutlet var rePass: UITextField!
    @IBOutlet var passCheck: UIButton!
    @IBOutlet var rePassCheck: UIButton!
  
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
     var webView: WKWebView!
    
     var stuff: Any!

    override func viewDidLoad() {
        super.viewDidLoad()
        genButton.alpha = 0.5
        genButton.isEnabled = false
     
    }



    @IBAction func Generate()
    {

        genButton.alpha = 0.5
        genButton.isEnabled = false
      
        
        pass.isUserInteractionEnabled = false
        rePass.isUserInteractionEnabled = false
        pass.isEnabled = false
        rePass.isEnabled = false
            // It generates an array of random mnemonic words. Use it for back-ups.
            // You can specify which language to use for the sentence by second parameter.
            
        
             let mnemonic = Mnemonic.create(strength: .normal, language: .english)
        print(mnemonic)
            // Then generate seed data from the mnemonic sentence.
            // You can set password for more secure seed data.
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
            
            // Create wallet by passing seed data and which network you want to connect.
            // for network, EthereumKit currently supports mainnet and ropsten.
            let hdWallet = HDWallet(seed: seed, network: .mainnet)
            
            // Generate an address, or private key by simply calling
            let address = try? hdWallet.address(at: 0)
        let privKey = try? hdWallet.privateKeyHex(at: 0)
            outAddress.text = address
            outPrivateKey.text = "0x" + privKey!
        let mnemonicStr = mnemonic.joined(separator: " ")
        outSeed.text = mnemonicStr
            //  outSeed.text! = mnemonic
       SaveAddress()
    }
    func SaveAddress()
    {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Wallet", in: context)
        let newWallet = NSManagedObject(entity: entity!, insertInto: context)
        newWallet.setValue(outAddress.text, forKey: "address")
        newWallet.setValue(pass.text, forKey: "password")
        newWallet.setValue(outPrivateKey.text, forKey: "privatekey")
        newWallet.setValue(outSeed.text, forKey: "seed")
        print("gonna encrypt adkjjdashgdsjghkgksfjhgjsdkghfskghk;jldjfkghf;slkgjbhjfhkhbl")
        do {
            let aes = try AES(key: "keykeykeykeykeyk", iv: "drowssapdrowssap") // aes128
            let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
            print(ciphertext)
            stuff = ciphertext
        } catch { }
        
        do {
            let aes = try AES(key: "keykeykeykeykeyk", iv: "drowssapdrowssap") // aes128
            let ciphertext = try aes.decrypt(stuff as! Array<UInt8>)
            print(ciphertext)
        } catch { }
        
        
        
        do {
            print("trying to save")
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    @IBAction func ResignResponders()
    {
    

        pass.resignFirstResponder()
        rePass.resignFirstResponder()
        CheckStatus()
    }
    func CheckStatus()
    {
        //check if status buttons should be shown
        if pass.text?.count == 0
        {
            passCheck.isHidden = true
        }
        else
        {
            passCheck.isHidden = false
        }
        if rePass.text?.count == 0
        {
            rePassCheck.isHidden = true
        }
        else
        {
            rePassCheck.isHidden = false
        }
        
        //check whether the password  and password check are good then change status button color accordingly aswell as enabling or disabling the generate button
        
        if rePass.text == pass.text
        {
            rePassCheck.setTitle("i", for: .normal)
            rePassCheck.backgroundColor = UIColor(red: 205/255, green: 220/255, blue: 68/255, alpha: 1)
        }
        else
        {
            rePassCheck.setTitle("!", for: .normal)
            rePassCheck.backgroundColor = UIColor.red
        }
        
        if (pass.text?.count)! >= 5
        {
            passCheck.setTitle("i", for: .normal)
            passCheck.backgroundColor = UIColor(red: 205/255, green: 220/255, blue: 68/255, alpha: 1)
        }
        else
        {
            passCheck.setTitle("!", for: .normal)
            passCheck.backgroundColor = UIColor.red
        }
        if rePass.text == pass.text && (pass.text?.count)! >= 5 && outAddress.text!.count == 0
        {
            genButton.alpha = 1
            genButton.isEnabled = true
        }
        else{
            genButton.alpha = 0.5
            genButton.isEnabled = false
        }
    }
    @IBAction func PassCheckInfo ()
    {
        if (pass.text?.count)! >= 5
        {
            let alert = UIAlertController(title: "Password", message: "Password meets requirements", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Password", message: "Password must be atleast 5 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }

    }
    @IBAction func RePassCheckInfo ()
    {
        if (pass.text?.count)! >= 5
        {
            let alert = UIAlertController(title: "Password", message: "Password fields match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else
        {
            let alert = UIAlertController(title: "Password", message: "Password fields do not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @IBAction func ChangeField()
    {
        CheckStatus()
    }
    @IBAction func ClearData()
    {
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Wallet", in: context)
        let newWallet = NSManagedObject(entity: entity!, insertInto: context)
        
        newWallet.setValue("", forKey: "address")
        newWallet.setValue("", forKey: "password")
        newWallet.setValue("", forKey: "privatekey")
        newWallet.setValue("", forKey: "seed")
        
        do {
            print("trying to save")
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    @IBAction func CopyAddress()
    {
        UIPasteboard.general.string = outAddress.text
    }
    
    @IBAction func CopyPrivate()
    {
        UIPasteboard.general.string = outPrivateKey.text
    }
    @IBAction func CopySeed()
    {
        UIPasteboard.general.string = outSeed.text
    }
}

