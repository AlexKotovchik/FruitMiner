//
//  ScoresViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 5.04.22.
//

import UIKit

class ScoresViewController: UIViewController {
    
    lazy var scores = setupScores()

    @IBOutlet weak var scoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }
    
    func setupScores() -> [Score]  {
        let scores = Storage.shared.scores
        let sortedScores = scores.sorted { $0.score > $1.score }
        return sortedScores
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension ScoresViewController {
    func setupTableView() {
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
    }
}

extension ScoresViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = scoresTableView.dequeueReusableCell(withIdentifier: "ScoreCell") as! ScoreTableViewCell
        cell.playerLabel.text = "\(indexPath.row + 1). \(scores[indexPath.row].playerName)"
        cell.scoreLabel.text = "\(scores[indexPath.row].score)"
        return cell
    }
    
    
}

extension ScoresViewController: UITableViewDelegate {
    
}
