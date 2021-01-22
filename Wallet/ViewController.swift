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
  
  @IBOutlet weak var gradientView: UIView!
  
  var demoTransactions: [Transaction] = []
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupChartLayout()
    addGradient()
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
  
  private func addGradient() {
    let colorTop = UIColor(red: 35.0 / 255.0, green: 210.0 / 255.0, blue: 221.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 29.0 / 255.0, green: 96.0 / 255.0, blue: 225.0 / 255.0, alpha: 1.0).cgColor
    
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorTop, colorBottom]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    gradientLayer.frame = gradientView.bounds
    
    gradientView.layer.insertSublayer(gradientLayer, at: 0)
    gradientView.layer.cornerRadius = 20
    gradientView.clipsToBounds = true
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
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return demoTransactions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = transactionTableView.dequeueReusableCell(withIdentifier: "transactionCell") as! TransactionTableViewCell
    cell.setupWith(transaction: demoTransactions[indexPath.row])
    return cell
  }
}
