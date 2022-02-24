//
//  ViewController.swift
//  lection_tableView
//
//  Created by Андрей Рыбалкин on 22.02.2022.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    let header = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifire)

//        tableView.sectionHeaderHeight = header.frame.height
//        tableView.tableHeaderView?.addSubview(header)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifire, for: indexPath) as! PostTableViewCell
        cell.setConfigureOfCell(
            title: posts[indexPath.row].title,
            image: posts[indexPath.row].image,
            description: posts[indexPath.row].description,
            likes: posts[indexPath.row].likes,
            views: posts[indexPath.row].views
        )

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

    
////    private let myArray: NSArray = ["Andrey", "Ivan", "Sergey", "Ruslan", "Asif", "John", "Anna", "Greg", "Julia 💛"]
//
//    private var myTableView: UITableView!
//
//    private var postTableViewCell = PostTableViewCell()
//
//    private var header = ProfileHeaderView()
//
//    private var postArray: [Post] = [post_1, post_2, post_3, post_4, post_5]
//
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.view.backgroundColor = .white
//
//        myTableView = UITableView()
//
//        myTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        myTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
//        myTableView.rowHeight = postTableViewCell.frame.height // какого черта???
//        myTableView.tableHeaderView = header
//        myTableView.dataSource = self
//        myTableView.delegate = self
//
//        self.view.addSubview(myTableView)
//
//        setupConstraints()
//    }
//
//    func setupConstraints () {
//
//        NSLayoutConstraint.activate([
//
//            myTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            myTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            myTableView.topAnchor.constraint(equalTo: view.topAnchor),
//            myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//
//        ])
//    }
//}
//
//extension ProfileViewController: UITableViewDataSource {
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
//        cell.addSubview(cell)
//
//        //        cell.textLabel!.text = "\(myArray[indexPath.row])"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        print("Num: \(indexPath.row)")
////        print("Value: \(myArray[indexPath.row])")
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return posts.count
//    }
//}
//
//extension ProfileViewController: UITableViewDelegate {}
//
//
//// MARK: Keyboard hedding method
//
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

