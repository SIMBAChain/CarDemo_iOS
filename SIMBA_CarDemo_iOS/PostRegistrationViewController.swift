//
//  PostRegistrationViewController.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/18/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//
import Foundation
import UIKit
import CoreData
import Alamofire
import EthereumKit
class PostRegistrationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //this is the view where the user can post
    @IBOutlet var image:UIImageView!
    @IBOutlet var make:UITextField!
    @IBOutlet var model:UITextField!
    @IBOutlet var vin:UITextField!
    
    let imagePickerController = UIImagePickerController()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var address:String!
    var savedSeed:String!
    var savedPrivateKey:String!
    var postresponse = [String:AnyHashable]()
    var isImage = false
    override func viewDidAppear(_ animated: Bool)
    {
        //get adrress for the purpose of signing transaction
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Wallet")
        request.returnsObjectsAsFaults = false
        do {
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print("set dat address")
                address = data.value(forKey: "address") as? String
                savedSeed = data.value(forKey: "seed") as? String
                savedPrivateKey = data.value(forKey: "privatekey") as? String
            }
            
        } catch {
            
            print("Failed")
        }
    }
    
    func ResignResponders()
    {
        make.resignFirstResponder()
        model.resignFirstResponder()
        vin.resignFirstResponder()
    }
    
    @IBAction func ResignButton()
    {
        ResignResponders()
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
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
    
    
    @IBAction func AddImage()
    {
        ResignResponders()
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.allowsEditing = false
                self.imagePickerController.sourceType = UIImagePickerController.SourceType.camera
                self.imagePickerController.cameraCaptureMode = .photo
                self.imagePickerController.modalPresentationStyle = .fullScreen
                self.imagePickerController.delegate = self
                self.present(self.imagePickerController,animated: true,completion: nil)
            } else {
                self.noCamera()
            }
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { action in
            // UIImagePickerController is a view controller that lets a user pick media from their photo library.
            
            
            // Only allow photos to be picked, not taken.
            self.imagePickerController.sourceType = .photoLibrary
            
            // Make sure ViewController is notified when the user picks an image.
            self.imagePickerController.delegate = self
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        image.image = selectedImage
        isImage = true
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //POSTING
    @IBAction func Post()
    {
        //The posting is done straight through alamofire instead of using swagger
        //I found it easier to do it this way with the usage of multipart form data
        let uploadmake = self.make.text
        let uploadmodel = self.model.text
        let uploadvin = self.vin.text
        let imgData = self.image.image!.jpegData(compressionQuality: 0.2)
        //the upload command
        Alamofire.upload(
            
            //define form data
            multipartFormData: { multipartFormData in
                
                multipartFormData.append((uploadmake! as String).data(using: String.Encoding.utf8)!, withName: "Make")
                multipartFormData.append((uploadmodel! as String).data(using: String.Encoding.utf8)!, withName: "Model")
                multipartFormData.append((uploadvin! as String).data(using: String.Encoding.utf8)!, withName: "VIN")
                multipartFormData.append((self.address! as String).data(using: String.Encoding.utf8)!, withName: "from")
                if (self.isImage == true)
                {
                    
                    
                    multipartFormData.append(imgData!, withName: "file[0]", fileName: "image.png", mimeType: "image/jpeg")
                }
                
                
        },
            //define url
            to: "https://api.simbachain.com/v1/ioscardemo2/registerCar/",
            /*Define headers in this case it is just your APIKEY from SIMBA*/       headers:[
                "APIKEY":"0ce2c6f644fa15bfb25520394392af4f835153a6be1beff0c096988d647a97c4"],
                                                                                    
                                                                                    encodingCompletion: { encodingResult in
                                                                                        /*Here is the result of your transaction*/             switch encodingResult {
                                                                                        case .success(let upload, _, _):
                                                                                            upload.responseJSON { response in
                                                                                                debugPrint(response)
                                                                                                print("--------------------------------^^^RESULT^^^--------------------------------")
                                                                                                self.postresponse = response.result.value! as! [String : AnyHashable]
                                                                                                // if it was posted it is then signed
                                                                                                self.SignTransaction(response: response.result.value! as! NSDictionary /*[String : AnyHashable]*/)
                                                                                            }
                                                                                        case .failure(let encodingError):
                                                                                            print(encodingError)
                                                                                        }
        }
        )
        
        
        
        
    }
    func SignTransaction(response:NSDictionary)
    {
        //gets the data needed from the model and sets it to the "data" variable
        let postpayload = response["payload"] as! [String : AnyHashable]
        let postRaw = postpayload["raw"] as! [String : AnyHashable]
        let data = (postRaw["data"]! as! String)
        let id = response["id"]! as! String
        //recreates your saved wallet locally to call the hwallet.sign function
        let mnemonic = self.savedSeed.components(separatedBy: " ")
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        let hdWallet = HDWallet(seed: seed, network: .mainnet)
        
        //sign the data with ethereumkit hdwallet.sign
        //NOTE: hdwallet.sign has 3 versions the hex string version is what's used below
        print("SIGNING")
        if let signedTransaction = try? hdWallet.sign(hex: data, withPrivateKeyAtIndex: 0)
        {
            print("signed Transaction")
            print(signedTransaction)
            //Signed transaction is submitted to SIMBA API
            //define parameters
            let parameters: Parameters = [
                "payload":String(signedTransaction)
            ]
            //define headers
            let headers: HTTPHeaders = ["APIKEY":"0ce2c6f644fa15bfb25520394392af4f835153a6be1beff0c096988d647a97c4"]
            //make the post request
            Alamofire.request(("https://api.simbachain.com/v1/ioscardemo2/transaction/" + id + "/"), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")
                //alerts the user that their transaction has been posted and signed
                response.result.ifSuccess
                    {
                        let alertVC = UIAlertController(
                            title: "Posted",
                            message: "Your transaction has been signed and posted" ,
                            preferredStyle: .alert)
                        let okAction = UIAlertAction(
                            title: "OK",
                            style:.default,
                            handler: nil)
                        alertVC.addAction(okAction)
                        self.present(alertVC,animated: true,completion: nil)
                }
            }
        }
    }
    
    
}
