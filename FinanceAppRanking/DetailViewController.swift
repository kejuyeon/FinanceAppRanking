//
//  DetailViewController.swift
//  FinanceAppRanking
//
//  Created by Juyeon Kim on 2018. 4. 20..
//  Copyright © 2018년 Juyeon Kim. All rights reserved.
//

import UIKit

extension Double { /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var appIcon: MyImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var contentAdvisoryRating: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    @IBOutlet weak var screenshotView: UIScrollView!
    @IBOutlet weak var appStoreButton: UIButton!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var ranking: UILabel!
    @IBOutlet weak var category: UILabel!
    
    var entry: Entry?
    var infoList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.largeTitleDisplayMode = .never
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.appIcon.imageLayerCornerAndBorder(radius: 20.0, borderWith: 0.3, color: UIColor.lightGray.cgColor)
        self.appStoreButton.buttonCornerRadius(radius: 15.0)
        loadDetailData()
    }
    
    @IBAction func appStoreOpen(_ sender: Any) {
        guard let url = URL(string: (entry?.link.attributes?.href)!) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func loadDetailData() {
        guard let id = entry?.id.attributes?.id else { return }
        self.category.text = entry?.category.label
        self.ranking.text = "# \(self.view.tag+1)"
        self.category.text = self.entry?.category.attributes?.label
        Utils.shared.loadDetailData(iTunesRSS.topfreeRankDetail(id).urlStr, loadCompleteHandler)
    }
    
    
    func loadCompleteHandler(_ detail: Detail) {
        guard let detail = detail.results?.first else { return }
        name.text = detail.trackName
        artistName.text = detail.artistName
        appIcon.downloadImageFrom(detail.artworkUrl512!)
        appDescription.text = detail.description
        rating.text = "버전 \(detail.version!)"
        contentAdvisoryRating.text = detail.contentAdvisoryRating

        guard let screenshots = detail.screenshotUrls else {return}
        var xPositon = CGFloat(0)
        for screenshot in screenshots {
            let imageView = MyImageView(frame: CGRect(x: xPositon, y: CGFloat(0), width: self.screenshotView.frame.size.width, height: self.screenshotView.frame.size.height))
            self.screenshotView.addSubview(imageView)
            xPositon += self.view.frame.size.width
            imageView.downloadImageFrom(screenshot, .scaleAspectFit)
        }
        self.screenshotView.contentSize = CGSize(width: xPositon, height: (self.screenshotView?.frame.size.height)!)
        // ["판매자","크기", "카테고리", "연령"]
        self.infoList.append(detail.sellerName!)
        self.infoList.append("\((Double(detail.fileSizeBytes!)!/1048576.0).roundToPlaces(places: 2)) MB")
        self.infoList.append((detail.genres?.first)!)
        self.infoList.append(detail.contentAdvisoryRating!)
        self.infoTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InfoTableViewCell
        let titles = ["판매자","크기", "카테고리", "연령"]
        cell.titleText?.text = titles[indexPath.row]
        cell.subTitleText.text = infoList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        if tableView.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
