//
//  FaceLivenessParams.swift
//  Runner
//
//  Created by Tim Guo on 2023/8/14.
//


@objcMembers class FaceLivenessParams : NSObject {
    public var apiId     : String = ""
    public var hostUrl   : String = ""
    public var apiSecret : String = ""
    public static let instance = FaceLivenessParams()
}
