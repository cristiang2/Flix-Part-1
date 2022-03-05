//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Cristian Guerrero on 3/3/22.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // layout object, you have to cast it to flow layout type
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        // how to configure a layout to do what you want
        // controls space between rows
        layout.minimumLineSpacing = 4
        
        // inner item spacing
        layout.minimumInteritemSpacing = 4
        
        // the way to access the width of the phone; size.width will change depending on what phone user is running app on
        // three posters needed, so divide by 3
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        layout.itemSize = CGSize(width: width, height: width * 1.5)

        // download superhero movies
        let url = URL(string: "https://api.themoviedb.org/3/movie/634649/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                self.movies = dataDictionary["results"] as! [[String:Any]]
                // at this point movies are stored in a property available to me in other functions
                // the download is complete at this point so next thing is to reload data because at this point the movies count has been updated
                
                self.collectionView.reloadData()
                print(self.movies)
                 
                // JSON file data is moved into app and I can now work with it
                print(dataDictionary)
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
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
