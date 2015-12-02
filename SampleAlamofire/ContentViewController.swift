//
//  ContentViewController.swift
//  SampleAlamofire
//
//  Created by 二俣征嗣 on 2015/12/02.
//  Copyright © 2015年 Masatsugu Futamata. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var data: String!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(data: String) {
        self.data = data

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData(data, webView: webView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func loadData(data: String, webView: UIWebView) {
        let htmlString = getHtmlString("index")
        let loadString = htmlString.stringByReplacingOccurrencesOfString("replaceString", withString: data)

        let path = getPath("index", type: "html")
        webView.loadHTMLString(loadString, baseURL: NSURL(string: path)!)
    }

    func getHtmlString(filename: String) -> String {
        let path = getPath(filename, type: "html")
        let fileHandle = NSFileHandle(forReadingAtPath: path)
        let fileData = fileHandle!.readDataToEndOfFile()
        let htmlString = String(data: fileData, encoding: NSUTF8StringEncoding)
        return htmlString!
    }

    func loadMarkdownData(data: String, webView: UIWebView) {
        let htmlString = getHtmlString("marked")
        let loadString = htmlString.stringByReplacingOccurrencesOfString("replaceString", withString: data)

        let path = getPath("marked", type: "html")
        webView.loadHTMLString(loadString, baseURL: NSURL(string: path)!)
    }

    func getPath(name: String, type: String) -> String {
        let mainBundle = NSBundle.mainBundle()
        let path = mainBundle.pathForResource(name, ofType: type)!
        return path
    }
}
