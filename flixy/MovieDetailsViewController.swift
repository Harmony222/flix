//
//  MovieDetailsViewController.swift
//  flixy
//
//  Created by Harmony Scarlet on 2/25/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
        
    var movie: [String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(movie!)

        // Do any additional setup after loading the view.
        titleLabel.text = movie["title"] as? String
        titleLabel.sizeToFit()
        
        synopsisLabel.text = movie["overview"] as? String
        synopsisLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)

        posterView.af.setImage(withURL: posterUrl!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        
        backdropView.af.setImage(withURL: backdropUrl!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(self.posterTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        posterView.addGestureRecognizer(tapGestureRecognizer)
        posterView.isUserInteractionEnabled = true

    }
    
    @IBAction func posterTap(_ sender: UITapGestureRecognizer) {
        print("tapped")
//        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = mainStoryboard.instantiateViewController(withIdentifier: "MovieTrailerViewController") as! MovieTrailerViewController
//        self.present(VC, animated: true, completion: nil)
        performSegue(withIdentifier: "trailerSegue", sender: nil)

   
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("loading up")
        let trailerViewController = segue.destination as! MovieTrailerViewController
        let movieId = self.movie["id"]
        trailerViewController.movieId = movieId as? Int
     
   
    }
    


}
