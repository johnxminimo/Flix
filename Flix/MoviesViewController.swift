//
//  MoviesViewController.swift
//  Flix
//
//  Created by John Minimo on 2/1/22.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    var movies = [[String:Any]]()

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print("Hello")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                    
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    
                    //print(dataDictionary)
                    self.tableView.reloadData()
                 
                    

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        
        
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        
        
        
        // Swift Optionals
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        print ("Loading up the details screen")
        
        // 2 steps
        
        // find the selected movie
        // sender is the cell that was tapped on
        let cell = sender as! UITableViewCell
        
        // indexPath is given by cell that was tapped on
        let indexPath = tableView.indexPath(for: cell)!
  
        // Access movies array with indexPath index for correct movie
        let movie = movies[indexPath.row]
        
        let detailsViewConroller = segue.destination as! MovieDetailsViewController
        // set movie dictionary in MovieDetailsViewController as movie var for movie
        detailsViewConroller.movie = movie
        // pass the selected movie to the details view controller
        
        // When transitioning deselect row so it isnt highlighted
        
        tableView.deselectRow(at: indexPath, animated:true)
        
    }
    

}
