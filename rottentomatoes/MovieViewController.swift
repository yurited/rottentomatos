//
//  MovieViewController.swift
//  rottentomatoes
//
//  Created by Li Yu on 9/17/14.
//  Copyright (c) 2014 Li Yu. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    var synopsisString:String?
    var titleString:String?
    var urlString:String?
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if(urlString != nil){
            self.posterView.setImageWithURL(NSURL(string:urlString!))
        }
        if(titleString != nil){
            self.titleLabel.text = titleString!
        }
        if(synopsisLabel != nil){
            self.synopsisLabel.text = synopsisString!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
