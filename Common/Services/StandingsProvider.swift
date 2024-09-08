//
//  StandingsProvider.swift
//  Footbalify
//
//  Created by Adam Jassak on 14/07/2024.
//

import Foundation
import OSLog

/// Protocol defining NFL Standings Provider methods and properties
protocol StandingsProviderProto {
    /// Method responsible for getting Default (Bundled JSON file) Standings
    ///
    ///  - Returns: Collection of Standings read from default/bundled JSON file
    func getDefaultStandings() -> [StandingsChildren]

    /// Method responsible fro transforming Standings Entries collection into array of `StandingsInfo` object
    ///
    ///  - Parameters: 
    ///     - Array of `ConferenceEntries`
    ///
    ///  - Returns: Array of `StandingsInfo`
    func transformStandings(entries: [ConferenceEntries]) -> [StandingsInfo]

    /// Method responsible for getting specific `StandingsInfo`, based on a provided Division
    ///
    ///  - Parameters:
    ///     - division: NFL Division that will be used for filtering Standings
    ///     - standings: Collection of RAW `StandingsChildren` values
    ///
    ///  - Returns: Array of `StandingsInfo` associated with specific division
    func getStandings(for division: Divisions,
                      standings: [StandingsChildren]) -> [StandingsInfo]

    /// Method responsible for getting specific `StandingsInfo`, based on a provided Team
    ///
    ///  - Parameters:
    ///     - team: NFL Team used for filtering Standings collection
    ///     - standings: Collection of RAW `StandingsChildren` values
    ///
    ///  - Returns: `StandingsInfo` object associated with specific team
    func getTeamStandings(team: Teams, standings: [StandingsChildren]) -> StandingsInfo

    /// Helper method reponsible for obtaining current NFL Standings
    ///
    ///  - Returns: Collection of Standings.
    ///  Either Persisted in UserDefault's - or if found empty, Found in Default Bundled JSON file
    func getFallbackStandings() -> [StandingsChildren]
}

/// Implementation of StandingsProvider Protocol
struct StandingsProvider: StandingsProviderProto {
    func getDefaultStandings() -> [StandingsChildren] {
        do {
            let bundledData = try Bundle.getDataContent(of: .standings)
            return getStandingsFromData(data: bundledData)
        } catch {
            Logger.generic.error("\(error)")
            return []
        }
    }

    func getFallbackStandings() -> [StandingsChildren] {
        let storedStandings = UserDefaults.getValue(for: .standings, defaultValue: Data())
        let standings = getStandingsFromData(data: storedStandings)

        guard !standings.isEmpty else {
            return getDefaultStandings()
        }
        return standings
    }

    func transformStandings(entries: [ConferenceEntries]) -> [StandingsInfo] {
        entries.map {
            let team = Teams.teamFromFullName(name: $0.team.displayName)
            let wins = $0.stats.first(where: {
                $0.name == "wins"
            })?.displayValue ?? String()
            let loses = $0.stats.first(where: {
                $0.name == "losses"
            })?.displayValue ?? String()
            let ties = $0.stats.first(where: {
                $0.name == "ties"
            })?.displayValue ?? String()
            let percentage = "0" + ($0.stats.first(where: {
                $0.name == "winPercent"
            })?.displayValue ?? ".0")
            let position = $0.stats.first(where: {
                $0.name == "playoffSeed"
            })?.displayValue ?? String()
            return StandingsInfo(team: team,
                                 wins: wins,
                                 loses: loses,
                                 ties: ties,
                                 percentage: percentage.starts(with: "0.") ? percentage : "1.000",
                                 position: position)
        }
    }

    func getStandings(for division: Divisions,
                      standings: [StandingsChildren]) -> [StandingsInfo] {
        let mainAfc = standings.filter {
            $0.abbreviation == Divisions.mainAfc.rawValue
        }
        let mainNfc = standings.filter {
            $0.abbreviation == Divisions.mainNfc.rawValue
        }

        guard !mainAfc.isEmpty, !mainNfc.isEmpty else {
            Logger.generic.warning("Empty collection found in provided Standings.")
            return []
        }

        let afcInfo = transformStandings(entries: mainAfc[0].standings.entries)
        let nfcInfo = transformStandings(entries: mainNfc[0].standings.entries)

        var standingsFiltered: [StandingsInfo] {
            switch division {
            case .mainAfc:
                afcInfo.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .mainNfc:
                nfcInfo.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .afcNorth:
                afcInfo.filter {
                    $0.team.division == .afcNorth
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .afcSouth:
                afcInfo.filter {
                    $0.team.division == .afcSouth
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .afcEast:
                afcInfo.filter {
                    $0.team.division == .afcEast
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .afcWest:
                afcInfo.filter {
                    $0.team.division == .afcWest
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .nfcNorth:
                nfcInfo.filter {
                    $0.team.division == .nfcNorth
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .nfcSouth:
                nfcInfo.filter {
                    $0.team.division == .nfcSouth
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .nfcEast:
                nfcInfo.filter {
                    $0.team.division == .nfcEast
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .nfcWest:
                nfcInfo.filter {
                    $0.team.division == .nfcWest
                }.sorted(by: {
                    positionSorter(team1: $0, team2: $1)
                })
            case .other:
                nfcInfo.filter {
                    $0.team.division == .other
                }
            }
        }
        return standingsFiltered
    }

    func getTeamStandings(team: Teams, standings: [StandingsChildren]) -> StandingsInfo {
        let mainAfc = standings.filter {
            $0.abbreviation == Divisions.mainAfc.rawValue
        }
        let mainNfc = standings.filter {
            $0.abbreviation == Divisions.mainNfc.rawValue
        }

        guard !mainAfc.isEmpty, !mainNfc.isEmpty else {
            Logger.generic.warning("Empty collection found in provided Standings.")
            return .demoInfo
        }

        let rawStandings = mainAfc[0].standings.entries + mainNfc[0].standings.entries
        let transformedStandings = transformStandings(entries: rawStandings)

        let finalStandings = transformedStandings.filter {
            $0.team == team
        }.first

        guard let finalStandings else {
            Logger.generic.warning("No Standings found associated with \(team.fullName) team.")
            return .demoInfo
        }
        return finalStandings
    }

    // MARK: - Private methods
    /// Helper method responsible for sorting NFL Team's position
    ///
    ///  - Parameters:
    ///     - team1: `StandingsInfo` of first team used in comparison
    ///     - team2: `StandingsInfo` of second team used in comparison
    ///
    ///  - Returns: Boolean value indicating whether sorted team shall be pushed to an Index 0
    private func positionSorter(team1: StandingsInfo, team2: StandingsInfo) -> Bool {
        if team1.position == "0" && team2.position != "0" {
            return false
        } else if team1.position != "0" && team2.position == "0" {
            return true
        } else {
            return Int(team1.position) ?? 0 < Int(team2.position) ?? 0
        }
    }

    /// Helper method responsible for transforming Data into collection of `StandingsChildren`
    ///
    ///  - Parameters:
    ///     - data: Data that will be decoded
    ///
    ///  - Returns: Decoded collection of `StandingsChildren` type describing Standings
    private func getStandingsFromData(data: Data) -> [StandingsChildren] {
        do {
            let decodedData: SeasonStandings = try JSONDecoder.decodeJson(data: data)
            return decodedData.children
        } catch {
            Logger.generic.error("\(error)")
            return []
        }
    }
}
