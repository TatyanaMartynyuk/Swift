import UIKit

class MovieListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var searchBar: UISearchBar!

    var actors: [Person] = [Person]()
    var task: NSURLSessionTask?
    
    override func viewDidLoad() {
        taskForCredits()
        let task = taskForCredits()
        task.resume()
    }
    
    // Create a Task
    func taskForCredits() -> NSURLSessionTask {
    
        let params = ["id": "284052"]
        let URL = TMDBURLs.URLForResource(resource: TMDB.Resources.MovieIDCredits, parameters: params)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(URL, completionHandler: handleResponse)
        return task
    }
    
    // This method will be invoked on a background thread, when the data task completes
    func handleResponse(data: NSData?, response: NSURLResponse?, error: NSError?) {
        if let error = error {
            print(error)
        }
        if let data = data {
            let JSONObejct = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
            let castDictionaries = JSONObejct["cast"] as! [[String: AnyObject]]
            print(castDictionaries)
            self.actors = [Person]()
            
            for d in castDictionaries {
                actors.append(Person(dictionary: d)!)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Toggle UI while downloading
    func setUIToDownloading(isDownloading: Bool) {
        
        if isDownloading {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        self.activityIndicator.hidden = isDownloading
        self.tableView.alpha = isDownloading ? 0.2 : 1.0
    }
    
    // MARK: - Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actors.count
    }
    
    var cellNumber = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TaskAwareTableViewCell
        var actor = actors[indexPath.row]
        cell.textLabel!.text = actor.name
        
        if actor.imagePath == nil {
            cell.imageView!.image = UIImage(named: "noImage")
        } else if let image = actor.profileImage {
            cell.imageView!.image = image
        } else {
            cell.imageView!.image = UIImage(named: "placeHolder")
            let url = TMDBURLs.URLForPosterWithPath(actor.imagePath!)
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
                data, response, error in
                if let error = error {
                    print(error)
                }
                if let data = data, let image = UIImage(data: data) {
                    actor.profileImage = image
                    dispatch_async(dispatch_get_main_queue()) {
                        cell.imageView!.image = image
                    }
                }
            }
            cell.taskToCancelWhenReused = task
            task.resume()
        }
        return cell
    }
}
