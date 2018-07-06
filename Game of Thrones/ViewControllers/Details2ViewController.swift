//
//  Details2ViewController.swift
//  Game of Thrones
//
//  Created by Macho Man on 7/3/18.
//  Copyright © 2018 siddharth. All rights reserved.
//

import UIKit
import CoreData

class Details2ViewController: UIViewController {
let Delegate = UIApplication.shared.delegate as! AppDelegate
@IBOutlet weak var Name: UILabel!
@IBOutlet weak var ImageView: UIImageView!
@IBOutlet weak var PageRank: UILabel!
@IBOutlet weak var Gender: UILabel!
@IBOutlet weak var Culture: UILabel!
@IBOutlet weak var House: UILabel!
@IBOutlet weak var Books: UITextView!
@IBOutlet weak var Titles: UITextView!

var Game = [NSManagedObject]()

//Function to create Container
func GetContex()-> NSManagedObjectContext
{
let Delegate = UIApplication.shared.delegate as! AppDelegate
return Delegate.persistentContainer.viewContext
}
    
//Function to Fetch Data
func FetchData()
{
let Context = GetContex()
let FetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
do
{
Game = try Context.fetch(FetchRequest) as! [NSManagedObject]
}
catch
{
print("Failed to Fetch Data")
}
}

override func viewDidAppear(_ animated: Bool) {
Name.text = (Game[MyIndex].value(forKey: "name") as! String)
let Photo = (Game[MyIndex].value(forKey: "image") as! NSData)
ImageView.image = UIImage(data: Photo as Data)
Gender.text = (Game[MyIndex].value(forKey: "gender") as! String)
Culture.text = (Game[MyIndex].value(forKey: "culture") as! String)
House.text = (Game[MyIndex].value(forKey: "house") as! String)
Titles.text = (Game[MyIndex].value(forKey: "titles") as! String)
Books.text = (Game[MyIndex].value(forKey: "books") as! String)
PageRank.text = (Game[MyIndex].value(forKey: "pagerank") as! String)
}
    
override func viewWillAppear(_ animated: Bool) {
FetchData()
}
    
override func viewDidLoad() {
// Design for UI Outlets
ImageView.layer.cornerRadius = 50.0
ImageView.layer.borderColor = UIColor.white.cgColor
ImageView.layer.borderWidth = 3.0
ImageView.clipsToBounds = false
ImageView.layer.masksToBounds = true
PageRank.layer.cornerRadius = 25.0
PageRank.layer.borderColor = UIColor.black.cgColor
PageRank.clipsToBounds = false
PageRank.layer.masksToBounds = true
PageRank.layer.borderWidth = 2.0
super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
