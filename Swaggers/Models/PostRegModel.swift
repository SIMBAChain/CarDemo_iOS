//
//  PostRegModel.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 11/1/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class PostRegModel: JSONEncodable {

    
    public var assetId: Any?
   
    public var vin: String?
    public var car: Any?
    public var make: String?
    public var model: String?
    public var from: String?
    
    
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        
        let body = NSMutableData()
        body.append("from=\(String(self.from!)), ".data(using: String.Encoding.utf8)!)
        body.append("VIN=\(String(self.vin!)), ".data(using: String.Encoding.utf8)!)
        body.append("Make=\(String(self.make!)), ".data(using: String.Encoding.utf8)!)
        body.append("Model=\(String(self.model!)), ".data(using: String.Encoding.utf8)!)
        body.append("assetId=0x000000, ".data(using: String.Encoding.utf8)!)
        body.append("car=0x000000".data(using: String.Encoding.utf8)!)
        
        print("body")
        let string1 = String(data: body as Data, encoding: String.Encoding.utf8)
        print(string1)
        print(body)
        nillableDictionary["from"] = self.from
        nillableDictionary["VIN"] = self.vin
        nillableDictionary["Make"] = self.make
        nillableDictionary["Model"] = self.model
        nillableDictionary["assetId"] = "0x000000"
        nillableDictionary["car"] = "0x000000"
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
