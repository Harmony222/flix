//
//  MovieTrailerViewController.swift
//  flixy
//
//  Created by Harmony Scarlet on 2/26/21.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {
    
    var movieId: Int!
    var result = [[String:Any]]()
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        print(movieId!)
        let movieIdStr = String(movieId)
        let url_str = "https://api.themoviedb.org/3/movie/" + movieIdStr + "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
//        print(url_str)
        let url = URL(string: url_str)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // Get movie trailer info
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.result = dataDictionary["results"] as! [[String:Any]]
//                print(dataDictionary)
             
                let key = self.result[0]["key"] as! String
                let myURL = URL(string:"https://www.youtube.com/watch?v=" + key)
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)

           }
        }
        task.resume()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
