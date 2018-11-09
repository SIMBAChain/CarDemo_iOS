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
        inputs["car"] = "0x000000"
        inputs["make"] = self.make
        inputs["model"] = self.model
        inputs["_bundleHash"] = ""
        
       // nillableDictionary["apiKey"] = self.apiKey
      //  inputs["assetId"] = self.assetId
        inputs["assetId"] = "0x000000"
        raw["from"] = self.from
        raw["data"] = "0x904803cd00000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000018030783030303030300000000000000000000000000000000000000000000000003078303030303030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e3078333533333334333333343335000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a3078343636663732363400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e307834363639363537333734363100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043078333000000000000000000000000000000000000000000000000000000000"
        payload["raw"] = self.raw
        payload["inputs"] = self.inputs
        payload["method"] = "registerCar"
        nillableDictionary["payload"] = self.payload
        
        nillableDictionary["transaction_hash"] = "null"
        nillableDictionary["error"] = "null"
        nillableDictionary["member_id"] = "null"
        nillableDictionary["group_id"] = "null"
        nillableDictionary["receipt"] = "null"
        nillableDictionary["is_asset"] = "true"
        nillableDictionary["user_id"] = "152"
        nillableDictionary["parent_id"] = "0x000000"
        nillableDictionary["organisation_id"] = "1f8ee8e7-1668-463b-9eaf-58f1b3f318fb"
        nillableDictionary["method_id"] = "9daab47c-b553-4f73-95aa-af050a80763d"
        nillableDictionary["data_store_id"] = "e329ca8a-ff24-4863-812c-6b9418acca2c"
        nillableDictionary["application_id"] = "a81881eb-1a1e-4722-8b6f-25a0fd31386f"
        nillableDictionary["adapter_id"] = "5f5dc9a7-05ac-4276-abec-4d2b0283ee1d"
        nillableDictionary["bytes_stored_on_datastore"] = "0"
        nillableDictionary["bundle_id"] = "null"
        nillableDictionary["bytes_stored_on_blockchain"] = "0"
        nillableDictionary["smart_contract_id"] = "04fa612a-5cd0-42b4-a0f1-f607855a194d"
        nillableDictionary["timestamp"] = "2018-11-02T20:11:42.345Z"
        
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
