//
//  LeagueVC.swift
//  app-swoosh
//
//  Created by Kent Nguyen on 10/24/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit

class LeagueVC: UIViewController {

    var player: Player!
    
    func selectLeague(leagueType: String) {
        player.desiredLeague = leagueType
        nextBtn.isEnabled = true
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var nextBtn: UIButton!
    
    // MARK: - IBAction
    
    @IBAction func onNextTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "skillVCSegue", sender: self)
    }
    @IBAction func onMensTapped(_ sender: UIButton) {
        selectLeague(leagueType: "mens")
    }
    @IBAction func onWomensTapped(_ sender: UIButton) {
        selectLeague(leagueType: "womens")
    }
    @IBAction func onCoedTapped(_ sender: UIButton) {
        selectLeague(leagueType: "coed")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = Player()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let skillVC = segue.destination as? SkillVC {
            skillVC.player = player
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
