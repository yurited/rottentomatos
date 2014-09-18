//
//  MoviesViewController.swift
//  rottentomatoes
//
//  Created by Li Yu on 9/17/14.
//  Copyright (c) 2014 Li Yu. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var progressView: MONActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UIView!
    
    var refreshControl:UIRefreshControl!
    var movies: [NSDictionary] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        progressView.startAnimating();
        tableView.delegate = self
        tableView.dataSource = self

        let YourApiKey = "uswbsm32ac5fwufwn8na5fan"
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            if (error != nil){
                self.networkErrorView.hidden = false
            } else {
                var errorValue: NSError? = nil
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.movies = dictionary["movies"] as [NSDictionary]
                self.tableView.reloadData()
            }
            self.progressView.hidden = true
            
        })
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refersh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        var movie = movies[indexPath.row]
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        cell.posterView.setImageWithURL(NSURL(string: posterUrl))
        
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        return cell
    }
    
    func refresh(sender:AnyObject) {
        self.refreshControl.endRefreshing()
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        if (segue.destinationViewController.isKindOfClass(MovieViewController)) {
            var movieController: MovieViewController = segue.destinationViewController as MovieViewController;
            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var movie = movies[indexPath.row]
            var images = movie["posters"] as NSDictionary
            var thumbnailUrl = images["thumbnail"] as String
            var urlString = thumbnailUrl.stringByReplacingOccurrencesOfString("tmb", withString: "org", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            movieController.urlString = urlString
            movieController.titleString = movie["title"] as? String
            movieController.synopsisString = movie["synopsis"] as? String

        }

    }
}