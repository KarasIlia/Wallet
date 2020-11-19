//
//  TransactionTableViewCell.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

  @IBOutlet weak var transactionTypeImage: UIImageView!
  @IBOutlet weak var transactionTypeLabel: UILabel!
  @IBOutlet weak var transactionDataLabel: UILabel!
  @IBOutlet weak var transactionAmount: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setupWith(transaction: Transaction) {
    switch transaction.type {
    case .withdraw:
      transactionTypeImage.image = UIImage(systemName: "arrow.down")
      transactionTypeLabel.text = "Вывод"
    case .deposit:
      transactionTypeImage.image = UIImage(systemName: "arrow.up")
      transactionTypeLabel.text = "Пополнение"
    case .transfer:
      transactionTypeImage.image = UIImage(systemName: "arrow.uturn.right")
      transactionTypeLabel.text = "Перевод"
    }
    
    transactionTypeImage.layer.borderColor = UIColor(displayP3Red: 227 / 255, green: 227 / 255, blue: 227 / 255, alpha: 1.0).cgColor
    transactionTypeImage.tintColor = UIColor(displayP3Red: 128 / 255, green: 128 / 255, blue: 128 / 255, alpha: 1.0)
    
    transactionAmount.text = "\(transaction.amount) \(transaction.currency ?? "руб")"
  }
}
