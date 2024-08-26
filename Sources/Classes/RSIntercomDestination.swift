//
//  RSAdjustDestination.swift
//  RudderIntercom
//
//  Created by Pallab Maiti on 27/03/22.
//

import Foundation
import Rudder
import Intercom

class RSIntercomDestination: RSDestinationPlugin {
    let type = PluginType.destination
    let key = "Intercom"
    var client: RSClient?
    var controller = RSController()
        
    func update(serverConfig: RSServerConfig, type: UpdateType) {
        guard type == .initial else { return }
        if let destination = serverConfig.getDestination(by: key), let config = destination.config?.dictionaryValue {
            if let mobileApiKey = config["mobileApiKeyIOS"] as? String, let appId = config["appId"] as? String {
                Intercom.setApiKey(mobileApiKey, forAppId: appId)
                
                if let traits = client?.context?["traits"] as? [String: Any]{
                    let userAttributes = ICMUserAttributes()
                    userAttributes.userId = traits["userId"] as? String
                    if let userId =  userAttributes.userId {
                     
                        Intercom.loginUser(with: userAttributes)
                    }
                  
                } else {
                   
                    Intercom.loginUnidentifiedUser()
                }
            }
        }
    }
    
    func identify(message: IdentifyMessage) -> IdentifyMessage? {
        let userAttributes = ICMUserAttributes()
        userAttributes.userId = message.userId
        if let userId =  userAttributes.userId {
          
            Intercom.loginUser(with: userAttributes)
        } else {
           
            Intercom.loginUnidentifiedUser()
        }
        
        if let traits = message.traits {
            let userAttributes = ICMUserAttributes()
            var customAttributes = [String: Any]()
            for (key, value) in traits {
                switch key {
                case "company":
                    if let companyTraits = value as? [String: String] {
                        let company = ICMCompany()
                        var customAttributes = [String: Any]()
                        for (key, value) in companyTraits {
                            switch key {
                            case "name":
                                company.name = value
                            case "id":
                                company.companyId = value
                            default:
                                customAttributes[key] = value
                            }
                        }
                        company.customAttributes = customAttributes
                    }
                case "name":
                    userAttributes.name = value as? String
                case "email":
                    userAttributes.email = value as? String
                case "phone":
                    userAttributes.phone = value as? String
                default:
                    customAttributes[key] = value
                }
            }
            userAttributes.customAttributes = customAttributes
            Intercom.updateUser(with: userAttributes)
        }
        return message
    }
    
    func track(message: TrackMessage) -> TrackMessage? {
        if let properties = message.properties {
            Intercom.logEvent(withName: message.event, metaData: properties)
        } else {
            Intercom.logEvent(withName: message.event)
        }
        return message
    }
    
    func screen(message: ScreenMessage) -> ScreenMessage? {
        client?.log(message: "MessageType is not supported", logLevel: .warning)
        return message
    }
    
    func group(message: GroupMessage) -> GroupMessage? {
        client?.log(message: "MessageType is not supported", logLevel: .warning)
        return message
    }
    
    func alias(message: AliasMessage) -> AliasMessage? {
        client?.log(message: "MessageType is not supported", logLevel: .warning)
        return message
    }
}

// MARK: - Support methods

@objc
public class RudderIntercomDestination: RudderDestination {
    
    public override init() {
        super.init()
        plugin = RSIntercomDestination()
    }
}
