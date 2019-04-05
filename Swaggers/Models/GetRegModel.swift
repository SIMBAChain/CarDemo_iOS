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
 
        
        nillableDictionary["count"] = self.count
        nillableDictionary["next"] = self.next
        nillableDictionary["previous"] = self.previous
        nillableDictionary["results"] = self.results
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
