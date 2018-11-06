//
//  GetRegModel.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/9/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//
import Foundation


open class GetRegModel: JSONEncodable {
    public var count: Int32?
    public var next: String?
    public var previous: String?
   // public var results : [String:AnyObject]?
    public var results : [NSDictionary]?
    public var id: String?
    public var parent: String?
    public var method: String?
    public var payload :[String:AnyObject]?
    public var inputs : [String:AnyObject]?
    public var vin: String?
    public var car: String?
    public var _bundlehash: String?
    public var make: String?
    public var model: String?
    public var raw : [String:AnyObject]?
    public var to: String?
    public var data: String?
    public var gasPrice: String?
    public var gas: String?
    public var value: String?
    public var from: String?
    public var gasLimit: String?
    public var nonce: String?
    public var payloadMethod: String?
    public var receipt: String?
    public var timestamp: String?
    public var application: String?
    public var organisation: String?
    public var group: String?
    public var member: String?
    public var user: String?
    public var transactionHash: String?
    public var smart_contract: String?
    public var adapter: String?
    public var is_asset: String?
    public var bytes_stored_on_blockchain: String?
    public var bundle: String?
    public var data_store: String?
    public var bytes_stored_on_datastore: String?
    public var error: String?
    public var status: String?
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["vin"] = self.vin 
        nillableDictionary["car"] = self.car
        nillableDictionary["_bundlehash"] = self._bundlehash
        nillableDictionary["make"] = self.make
        nillableDictionary["model"] = self.model
        nillableDictionary["to"] = self.to
        nillableDictionary["data"] = self.data
        nillableDictionary["gasprice"] = self.gasPrice
        nillableDictionary["gas"] = self.gas
        nillableDictionary["value"] = self.value
        nillableDictionary["from"] = self.from
        nillableDictionary["gaslimit"] = self.gasLimit
        nillableDictionary["nonce"] = self.nonce
         
        nillableDictionary["inputs"] = self.inputs
        nillableDictionary["raw"] = self.raw
        nillableDictionary["method"] = self.payloadMethod
         
        nillableDictionary["id"] = self.id
        nillableDictionary["parent"] = self.parent
        nillableDictionary["method"] = self.method
        nillableDictionary["payload"] = self.payload
        nillableDictionary["receipt"] = self.receipt
        nillableDictionary["timestamp"] = self.timestamp
        nillableDictionary["application"] = self.application
        nillableDictionary["organization"] = self.organisation
        nillableDictionary["group"] = self.group
        nillableDictionary["member"] = self.member
        nillableDictionary["user"] = self.user
        nillableDictionary["transactionHash"] = self.transactionHash
        nillableDictionary["smart_contract"] = self.smart_contract
        nillableDictionary["adapter"] = self.adapter
        nillableDictionary["is_asset"] = self.is_asset
        nillableDictionary["bytes_stored_on_blockchain"] = self.bytes_stored_on_blockchain
        nillableDictionary["bundle"] = self.bundle
        nillableDictionary["data_store"] = self.data_store
        nillableDictionary["bytes_stored_on_datastore"] = self.bytes_stored_on_datastore
        nillableDictionary["error"] = self.error
        nillableDictionary["status"] = self.status
        
        nillableDictionary["count"] = self.count
        nillableDictionary["next"] = self.next
        nillableDictionary["previous"] = self.previous
        nillableDictionary["results"] = self.results
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
