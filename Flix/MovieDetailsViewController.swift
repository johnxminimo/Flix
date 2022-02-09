//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by John Minimo on 2/8/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]! // ! and ? are swift optionals (research later)
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        print(movie["title"])
        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String

        synopsisLabel.text = movie["overview"] as? String
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        self.posterView.af.setImage(withURL: posterUrl!) // set posterView with poster image
        
        
        let backdropBaseUrl = "https://image.tmdb.org/t/p/original"
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: backdropBaseUrl + backdropPath)
        
        self.backgroundView.af.setImage(withURL: backdropURL!) // set backdropView with backdrop image
        
        
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
