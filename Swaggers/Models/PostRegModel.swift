//
//  PostRegModel.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 11/1/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class PostRegModel: JSONEncodable {

    // public var results : [String:AnyObject]?
    public var apiKey: String?
    public var assetId: Any?
    public var id: String?
    public var vin: String?
    public var car: Any?
    public var make: String?
    public var model: String?
    public var from: String?
    
    public var payload:[String:Any] = [:]
    public var inputs:[String:Any] = [:]
    public var raw:[String:Any] = [:]
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        
        
        
        inputs["vin"] = self.vin
      //  inputs["car"] = self.car
        inputs["car"] = 0x000000
        inputs["make"] = self.make
        inputs["model"] = self.model
        
        
       // nillableDictionary["apiKey"] = self.apiKey
      //  inputs["assetId"] = self.assetId
        inputs["assetId"] = 0x000000
        raw["from"] = self.from
        
        payload["raw"] = self.raw
        payload["inputs"] = self.inputs
        nillableDictionary["payload"] = self.payload
        
   
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
