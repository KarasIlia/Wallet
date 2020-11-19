//
//  ViewController.swift
//  Wallet
//
//  Created by Илья Карась on 16.11.2020.
//

import UIKit
import Charts

class ViewController: UIViewController {

  @IBOutlet weak var transactionTableView: UITableView!
  @IBOutlet weak var balanceValueLabel: UILabel!
  
  @IBOutlet weak var withdrawButton: DesignableButton!
  @IBOutlet weak var depositButton: DesignableButton!
  @IBOutlet weak var transferButton: DesignableButton!
  
  @IBOutlet weak var dynamicMoreButton: UIButton!
  @IBOutlet weak var transactionsAllButton: UIButton!
  
  @IBOutlet weak var chartView: LineChartView!
    
  var demoTransactions: [Transaction] = []
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupChartLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNeedsStatusBarAppearanceUpdate()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    updateGraph()
    demoTransactions = prepareTransactionsDemoData()
    transactionTableView.reloadData()
  }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func prepareTransactionsDemoData() -> [Transaction] {
    var transactions: [Transaction] = []
    
    for _ in 0...10 {
      let transaction = Transaction(type: Transaction.getRandomTransactionType(), date: Date(), amount: Int(arc4random_uniform(50000)))
      transactions.append(transaction)
    }
    
    return transactions
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return demoTransactions.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
    cell.setupWith(transaction: demoTransactions[indexPath.row])
    return cell
  }
}
