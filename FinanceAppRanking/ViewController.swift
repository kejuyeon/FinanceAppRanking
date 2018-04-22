//
//  ViewController.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 19..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var entry = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "인기차트"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        Utils.shared.loadEntryData(iTunesRSS.topfreeRank.urlStr, dataLoadCompletHandler(_:))
    }
    
    func dataLoadCompletHandler(_ data: [Entry]) {
        self.entry = data
        self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppItemCell
        let cellData = entry[indexPath.row]
        
        cell.rankingText.text = "\(indexPath.row + 1)"
        cell.titleText.text = cellData.name.label
        
        cell.thumImage.downloadImageFrom((cellData.images.last?.label)!, .scaleToFill)
        cell.thumImage.imageLayerCornerAndBorder(radius: 20.0, borderWith: 0.3, color: UIColor.lightGray.cgColor)

        cell.categoryText.text = cellData.category.attributes?.label
        cell.button.setTitle(cellData.price.label, for: .normal)
        cell.button.buttonCornerRadius(radius: 10.0)
        cell.button.addTarget(self, action: #selector(appStoreOpen(_:)), for: .touchUpInside)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let cellData = entry[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.entry = cellData
                controller.view.tag = indexPath.row
            }
        }
    }
    
    @IBAction func appStoreOpen(_ sender: Any) {
        let cellData = entry[(sender as! UIButton).tag]
        guard let url = URL(string: (cellData.link.attributes?.href)!) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

