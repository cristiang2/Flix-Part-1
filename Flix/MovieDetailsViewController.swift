//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Cristian Guerrero on 3/2/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    // movie is no longer an array; type is dictionary, keyed by str, value are Any
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    // Do any additional setup after loading the view.
    // proving that passed along movie that was selected into the navigation, using print statement
        // print(movie["title"])
    // whole movie dictionary is now passed along
    // I can use this dictionary to configure the view
    
        titleLabel.text = movie["title"] as? String
        // after you set the text, grow the label until it can fit everything in there
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        // the width that was available was 'w780' so that's what's edited at the end of the https://
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)

        
    }
    

    
   
    

}
