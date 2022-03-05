//
//  ViewController.swift
//  Flix
//
//  Created by Cristian Guerrero on 2/20/22.
//

import UIKit
import AlamofireImage

    /* we want the list of movies stored in the viewController to show in the table view
     vars created in this zone are called properties and are available for the lifetime of that screen
     syntax for an array []
     syntax for an array of dictionaries [[]]
     syntax for dictionary: type of key:type of value
     Parentheses to indicate the creation of (something) an array of dictionaries */
    var movies = [[String:Any]]()

// UITableViewDataSource and UITableViewDelegate allow view controller to work with tableView
// add 2 protocol stubs in order to work w tableView, will call these 2 functions
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // changed UITableViewCell() to tableView.dequeueReusableCell(withIdentifier: "MovieCell"), because at any given point I may have hundreds of different movies which would take up a lot of memory, so dequeueReusableCell says if another cell is offscreen, can you give me that recycled cell, and if no recycled cell available then create me a new one. you can only see a small fraction of the cells you have. we need to cast it with as! MovieCell to say hey this is a moviecell therefore I want to access it as a moviecell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        // indexPath.row will change and this tableView function gets called 50 times and 50 times it will configure this cell
        // to print movie title you need to get current movie. we have an array called movies and in order to understand which element to access, say indexPath.row, it will access first, 2nd, 3rd movie and will store it in movie
        let movie = movies[indexPath.row]
        // what's the title of that movie, need to access it by some key, how to know what to put inside brackets and inside quotations? -> go back to API and look @ the options and see something called title, it will give me value. then replace string in cell.textLabel!.text with
        let title = movie["title"] as! String
        
        // in the API, synopsis is called overview in dictionary
        let synopsis = movie["overview"] as! String
        
        // replaced this: "cell.textLabel!.text = title" with this:
        cell.titleLabel.text = title
        // configure synopsisLabel text to say 'synopsis'
        cell.synopsisLabel.text = synopsis
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // the sender in 'sender: Any?' is the cell that was tapped on
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
        print("loading up the details screen")
        // this str above outputs every time you click on a movie title
        // demonstrating that a new movie details screen will display
        // every time you click on a movie title
        
        // find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        // pass the selected movie to the details view controller
        // we need to cast it bc it would give me a generic view controller which wont give me access to movie property
        let detailsViewController = segue.destination as! MovieDetailsViewController
        // the second movie (= movie) is referring to the movie that we found in 'let movie = movies[indexPath.row]' line 69
        detailsViewController.movie = movie
        
        // manually deselecting the cell that we selected to view movie details. Without this the cell would still be shaded as our selection
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //this is a test to see that everything is loading
        print("Hello")
        
        tableView.rowHeight = 125
        
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
                    // dataDictionary variable has the fetched data
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 
                 // hey movies var look in dataDictionary and get out results, this is how you access a particular key inside of dictionary, it wants this to be cast 'as!' an array of dictionaries
                // sometimes you'll need to insert 'self' before movies to make it self.movies
                movies = dataDictionary["results"] as! [[String:Any]]
                // at this point movies are stored in a property available to me in other functions
                // the download is complete at this point so next thing is to reload data:
                 self.tableView.reloadData()
                 // above line has the tableView function called again and it waits for you to populate it
                 
                // JSON file data is moved into app and I can now work with it
                print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }


}

