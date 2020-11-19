//
//  Transaction.swift
//  Wallet
//
//  Created by Илья Карась on 17.11.2020.
//

import Foundation

struct Transaction {
  
  enum TransactionType: Int, CaseIterable {
    case withdraw, transfer, deposit
  }
  
  let type: TransactionType
  let date: Date
  let amount: Int
  let currency: String? = nil
  
  static func getRandomTransactionType() -> TransactionType {
    let maxEnumRawValue = UInt32(TransactionType.allCases.last!.rawValue)
    let randRaw = Int(arc4random_uniform(maxEnumRawValue))
    return TransactionType(rawValue: randRaw)!
  }
}
