//
//  ScheduleTitle.swift
//  Footbalify
//
//  Created by Adam Jassak on 12/07/2024.
//

import Foundation

/// List of all available Schedule Week Titles
enum ScheduleTitle: String, CaseIterable {
    case week1 = "WEEK 1", week2 = "WEEK 2", week3 = "WEEK 3"
    case week4 = "WEEK 4", week5 = "WEEK 5", week6 = "WEEK 6"
    case week7 = "WEEK 7", week8 = "WEEK 8", week9 = "WEEK 9"
    case week10 = "WEEK 10", week11 = "WEEK 11", week12 = "WEEK 12"
    case week13 = "WEEK 13", week14 = "WEEK 14", week15 = "WEEK 15"
    case week16 = "WEEK 16", week17 = "WEEK 17", week18 = "WEEK 18"
    case wildCard = "WILD CARD", divRd = "DIV RD"
    case confChamp = "CONF CHAMP", superBowl = "SUPER BOWL"

    /// Property mapping Schedule Title to Respective JSON file
    var toJsonFile: AppConstant {
        switch self {
        case .week1:
                .regWeek1
        case .week2:
                .regWeek2
        case .week3:
                .regWeek3
        case .week4:
                .regWeek4
        case .week5:
                .regWeek5
        case .week6:
                .regWeek6
        case .week7:
                .regWeek7
        case .week8:
                .regWeek8
        case .week9:
                .regWeek9
        case .week10:
                .regWeek10
        case .week11:
                .regWeek11
        case .week12:
                .regWeek12
        case .week13:
                .regWeek13
        case .week14:
                .regWeek14
        case .week15:
                .regWeek15
        case .week16:
                .regWeek16
        case .week17:
                .regWeek17
        case .week18:
                .regWeek18
        case .wildCard:
                .wildCard
        case .divRd:
                .divisionalRound
        case .confChamp:
                .conferenceChampionships
        case .superBowl:
                .superBowl
        }
    }

    /// Property mapping Schedule Title to Respective User Default's Key
    var toDefaultKey: DefaultKey {
        switch self {
        case .week1:
                .week1
        case .week2:
                .week2
        case .week3:
                .week2
        case .week4:
                .week4
        case .week5:
                .week5
        case .week6:
                .week6
        case .week7:
                .week7
        case .week8:
                .week8
        case .week9:
                .week9
        case .week10:
                .week10
        case .week11:
                .week11
        case .week12:
                .week12
        case .week13:
                .week13
        case .week14:
                .week14
        case .week15:
                .week15
        case .week16:
                .week16
        case .week17:
                .week17
        case .week18:
                .week18
        case .wildCard:
                .wildCard
        case .divRd:
                .divRd
        case .confChamp:
                .confChamp
        case .superBowl:
                .superBowl
        }
    }

    /// Boolean Flag indicating whether the NFL Week is part of regular season
    var isRegSeason: Bool {
        let nonRegSeason: [Self] = [.wildCard, .divRd, .confChamp, .superBowl]

        return if nonRegSeason.contains(self) {
            false
        } else {
            true
        }
    }

    /// Property mapping Schedule Title Week to it's Number value as represented by an Endpoint
    var toWeekNum: Int {
        switch self {
        case .week1:
            1
        case .week2:
            2
        case .week3:
            3
        case .week4:
            4
        case .week5:
            5
        case .week6:
            6
        case .week7:
            7
        case .week8:
            8
        case .week9:
            9
        case .week10:
            10
        case .week11:
            11
        case .week12:
            12
        case .week13:
            13
        case .week14:
            14
        case .week15:
            15
        case .week16:
            16
        case .week17:
            17
        case .week18:
            18
        case .wildCard:
            1
        case .divRd:
            2
        case .confChamp:
            3
        case .superBowl:
            5
        }
    }
}
