//
//  ViewController.swift
//  SampleAlamofire
//
//  Created by 二俣征嗣 on 2015/12/01.
//  Copyright © 2015年 Masatsugu Futamata. All rights reserved.
//

import UIKit
import Alamofire

class TopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let urlPrefix = "https://api.github.com"

    let urlList = ["/repos/paveway/Calendar/contents/lint.xml"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /**
     セクション内のセル数を返却する。

     - Parameter tableView: テーブルビュー
     - Parameter section: セクション番号
     - Return: セクション内のセル数
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlList.count
    }

    /**
     セルを返却する。

     - Parameter tableView: テーブルビュー
     - Parameter indexPath: インデックスパス
     - Return: セル
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell?
        if (cell == nil) {
            cell = UITableViewCell()
        }

        let row = indexPath.row

        cell!.textLabel?.text = urlList[row]

        return cell!
    }

    // MARK: - UITableViewDelegate

    /**
    セルが選択された時に呼び出される。

    - Parameter tableView: テーブルビュー
    - Parameter indexPath: インデックスパス
    　   */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let row = indexPath.row

        let url = "\(urlPrefix)\(urlList[row])"
        request(url)
    }

    func request(url: String) {
        let requestUrl = "\(urlPrefix)"
        Alamofire.request(.GET,requestUrl).responseJSON { response in
            debugPrint(response)     // prints detailed description of all response properties

            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization

            if let JSON = response.result.value {
                print("JSON=\(JSON)")
                let jsonDic = JSON as! NSMutableDictionary
                let keys = jsonDic.allKeys
                for key in keys {
                    let value = jsonDic.objectForKey(key)
                    print("\(value)")
                }

                //let vc = ContentViewController(data: values[0] as! String)
                //self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

