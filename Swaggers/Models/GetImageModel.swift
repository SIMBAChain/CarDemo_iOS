//
//  GetImageModel.swift
//  SIMBA_CarDemo_iOS
//
//  Created by Steven Peregrine on 10/31/18.
//  Copyright © 2018 ITAMCO. All rights reserved.
//

import Foundation

open class GetImageModel: JSONEncodable {
    public var bundle_hash: String?
    public var manifest: Array<Any>?
    public var name: String?
    public var mimetype: String?
    public var size: String?
    public var encoding: String?
     public var data: String?

    
    
    
    public init() {}
    
    // MARK: JSONEncodable
    func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["bundle_hash"] = self.bundle_hash
        nillableDictionary["manifest"] = self.manifest
        nillableDictionary["name"] = self.name
        nillableDictionary["mimetype"] = self.mimetype
        nillableDictionary["size"] = self.size
        nillableDictionary["encoding"] = self.encoding
        nillableDictionary["data"] = self.data
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
