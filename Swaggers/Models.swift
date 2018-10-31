// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    public let statusCode: Int
    public let header: [String: String]
    public let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        print(source)
        let array = [source]
            return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        if type(of: source) == NSNull.self {return [:]}
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [SIMBAData]
        
        Decoders.addDecoder(clazz: [GetRegModel].self) { (source: AnyObject) -> [GetRegModel] in
            print("[GetRegModelDecoder]")
           
            return Decoders.decode(clazz: [GetRegModel].self, source: source)
        }
        
        // Decoder for SIMBAData
        Decoders.addDecoder(clazz: GetRegModel.self) { (source: AnyObject) -> GetRegModel in
             print("GetRegModelDecoder")
            
            let sourceDictionary = source as! [AnyHashable: Any]
         // print(sourceDictionary)
            let instance = GetRegModel()
            //-------------------------------------------------------
            //--this is where the items are grabed from the backend--
            //-------------------------------------------------------
            
            
        
            var resultsarray: NSArray = sourceDictionary["results"] as! NSArray
            var results : [String : Any] = Decoders.decode(clazz: [String : Any].self, source: resultsarray.firstObject as AnyObject)
            if resultsarray.count == 0 {return instance}
                instance.count = Decoders.decode(clazz: Int32.self, source: (sourceDictionary["count"] as AnyObject?)!)
              var payload = results["payload"] as? [String : AnyObject]
            var inputs = payload!["inputs"] as? [String : AnyObject]
            instance.results = (resultsarray  as! [NSDictionary])
            instance.vin = inputs!["VIN"] as? String
              instance.car = inputs!["car"] as? String
              instance.make = inputs!["Make"] as? String
              instance.model = inputs!["Model"] as? String
                print("GetRegModelDecoder")
            return instance
        }
        
        // Decoder for [IMAGE]
        
        Decoders.addDecoder(clazz: [GetImageModel].self) { (source: AnyObject) -> [GetImageModel] in
            print("[GetRegModelDecoder]")
            
            return Decoders.decode(clazz: [GetImageModel].self, source: source)
        }
        
        // Decoder for IMAGE
        Decoders.addDecoder(clazz: GetImageModel.self) { (source: AnyObject) -> GetImageModel in
            print("GetRegModelDecoder")
            
            let sourceDictionary = source as! [AnyHashable: Any]
            // print(sourceDictionary)
            let instance = GetImageModel()
            //-------------------------------------------------------
            //--this is where the items are grabed from the backend--
            //-------------------------------------------------------
            
            
            
     
            instance.bundle_hash = (sourceDictionary["bundle_hash"] as! String)
            instance.manifest = (sourceDictionary["manifest"] as! Array<Any>)
   
            print("GetRegModelDecoder")
            return instance
        }
        
        
        
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
