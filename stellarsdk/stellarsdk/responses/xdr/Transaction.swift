//
//  Transaction.swift
//  stellarsdk
//
//  Created by Razvan Chelemen on 09/02/2018.
//  Copyright © 2018 Soneso. All rights reserved.
//

import UIKit

public struct Transaction: XDRCodable {
    public let sourceAccount: PublicKey
    public let fee: UInt32
    public let seqNum: UInt64
    public let timeBounds: TimeBounds?
    public let memo: Memo
    public let operations: [Operation]
    public let reserved: Int32 = 0
    
    public init(sourceAccount: PublicKey, seqNum: UInt64, timeBounds: TimeBounds?, memo: Memo, operations: [Operation]) {
        self.sourceAccount = sourceAccount
        self.seqNum = seqNum
        self.timeBounds = timeBounds
        self.memo = memo
        self.operations = operations
        
        self.fee = UInt32(100 * operations.count)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        sourceAccount = try container.decode(PublicKey.self)
        fee = try container.decode(UInt32.self)
        seqNum = try container.decode(UInt64.self)
        timeBounds = try container.decode(Array<TimeBounds>.self).first
        memo = try container.decode(Memo.self)
        operations = try container.decode(Array<Operation>.self)
        _ = try container.decode(Int32.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        
        try container.encode(sourceAccount)
        try container.encode(fee)
        try container.encode(seqNum)
        try container.encode(timeBounds)
        try container.encode(memo)
        try container.encode(operations)
        try container.encode(reserved)
    }
}