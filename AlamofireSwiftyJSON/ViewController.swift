//
//  ViewController.swift
//  AlamofireSwiftyJSON
//
//  Created by Nervana on 10/24/18.
//  Copyright © 2018 Nervana. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet var tableJSON: UITableView!
    var arrNames = [[String: AnyObject]]()
    //swiftlint:disable:next identifier_name
    var id = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
            if(responseData.result.value) != nil {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["contacts"].arrayObject {
                    self.arrNames = (resData as? [[String: AnyObject]])!
                }
                if self.arrNames.count > 0 {
                    self.tableJSON.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "jsonCell")!
        var dictonary = arrNames[indexPath.row]
        cell.textLabel?.text = dictonary["name"] as? String
        return cell
    }
}
