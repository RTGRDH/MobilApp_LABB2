//
//  Rules.swift
//  MobilApp_LABB2
//
//  Created by Carl-Bernhard Hallberg on 2020-11-22.
//

import Foundation
/*
 * The game board positions
 *
 * 03           06           09
 *     02       05       08
 *         01   04   07
 * 24  23  22        10  11  12
 *         19   16   13
 *     20       17       14
 * 21           18           15
 *
 */

class NineMenMorrisRules {
    private var gameplan : [Int]
    private var bluemarker, redmarker : Int
    private var turn : Int
    private var activeBlues, activeReds: Int

    static let BLUE_MOVES : Int = 1;
    static let RED_MOVES: Int = 2;

    static let EMPTY_SPACE: Int = 0;
    static let BLUE_MARKER : Int = 4;
    static let RED_MARKER: Int = 5;
        
    private var gameIsActive: Bool
    private let key = "dataForGame"
    
    struct nineMen: Codable{
        var gameplan : [Int]?
        var bluemarker, redmarker : Int?
        var turn : Int?
        var activeBlues, activeReds: Int?
    }
    init() {
        gameplan = Array(repeating: 0, count: 25) // zeroes
        bluemarker = 4
        redmarker = 4
        activeReds = 0
        activeBlues = 0
        gameIsActive = true
        //bluemarker = 9;
        //redmarker = 9;
        turn = 0
        turn = rand()
    }
    
    private func rand() -> Int{
        let random = Int.random(in: 0...1)
        if(random == 0) { return NineMenMorrisRules.BLUE_MOVES }else{
            return NineMenMorrisRules.RED_MOVES
        }
    }
    
    func getGamePlan() -> [Int]{
        return gameplan
    }
    
    func getGameState() -> Bool{
        return self.gameIsActive
    }
    
    func getActiveBlues() -> Int{
        return activeBlues
    }
    
    func getActiveReds() -> Int{
        return activeReds
    }
    
    func whosTurn() -> Int {
        return turn
    }
    
    func getBlueMarkersLeft() -> Int{
        return bluemarker
    }
    
    func getRedMarkersLeft() -> Int{
        return redmarker
    }
    /**
     * Returns true if a move is successful
     */
    func legalMove(To : Int, From : Int, color : Int) -> Bool{
        if (color == turn) {
            if (turn == NineMenMorrisRules.RED_MOVES) {
                if (redmarker > 0) {
                    if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                        gameplan[To] = NineMenMorrisRules.RED_MARKER;
                        self.redmarker-=1;
                        self.activeReds+=1
                        turn = NineMenMorrisRules.BLUE_MOVES;
                        return true;
                    }
                }
                if(activeReds == 3 && redmarker == 0){
                    if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                        gameplan[To] = NineMenMorrisRules.RED_MARKER;
                        gameplan[From] = NineMenMorrisRules.EMPTY_SPACE
                        turn = NineMenMorrisRules.BLUE_MOVES;
                        return true;
                    }
                }
                /*else*/
                if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                    let valid = isValidMove(to: To, from: From);
                    if (valid == true) {
                        gameplan[To] = NineMenMorrisRules.RED_MARKER;
                        gameplan[From] = NineMenMorrisRules.EMPTY_SPACE
                        turn = NineMenMorrisRules.BLUE_MOVES;
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                if (bluemarker > 0) {
                    if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                        gameplan[To] = NineMenMorrisRules.BLUE_MARKER;
                        self.bluemarker-=1;
                        self.activeBlues+=1
                        turn = NineMenMorrisRules.RED_MOVES;
                        return true;
                    }
                }
                if(activeBlues == 3 && bluemarker == 0){
                    if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                        gameplan[To] = NineMenMorrisRules.BLUE_MARKER;
                        gameplan[From] = NineMenMorrisRules.EMPTY_SPACE
                        turn = NineMenMorrisRules.RED_MOVES;
                        return true;
                    }
                }
                if (gameplan[To] == NineMenMorrisRules.EMPTY_SPACE) {
                    let valid = isValidMove(to: To, from: From);
                    if (valid == true) {
                        gameplan[To] = NineMenMorrisRules.BLUE_MARKER;
                        gameplan[From] = NineMenMorrisRules.EMPTY_SPACE
                        turn = NineMenMorrisRules.RED_MOVES;
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
        } else {
            return false;
        }
    }

    /**
     * Returns true if position "to" is part of three in a row.
     */
    func remove(to: Int) -> Bool {

        if ((to == 0 || to == 3 || to == 6) && gameplan[0] == gameplan[3]
                && gameplan[3] == gameplan[6]) {
            return true;
        } else if ((to == 1 || to == 4 || to == 7)
                && gameplan[1] == gameplan[4] && gameplan[4] == gameplan[7]) {
            return true;
        } else if ((to == 2 || to == 5 || to == 8)
                && gameplan[2] == gameplan[5] && gameplan[5] == gameplan[8]) {
            return true;
        } else if ((to == 6 || to == 9 || to == 12)
                && gameplan[6] == gameplan[9] && gameplan[9] == gameplan[12]) {
            return true;
        } else if ((to == 7 || to == 10 || to == 13)
                && gameplan[7] == gameplan[10] && gameplan[10] == gameplan[13]) {
            return true;
        } else if ((to == 8 || to == 11 || to == 14)
                && gameplan[8] == gameplan[11] && gameplan[11] == gameplan[14]) {
            return true;
        } else if ((to == 12 || to == 15 || to == 18)
                && gameplan[12] == gameplan[15] && gameplan[15] == gameplan[18]) {
            return true;
        } else if ((to == 13 || to == 16 || to == 19)
                && gameplan[13] == gameplan[16] && gameplan[16] == gameplan[19]) {
            return true;
        } else if ((to == 14 || to == 17 || to == 20)
                && gameplan[14] == gameplan[17] && gameplan[17] == gameplan[20]) {
            return true;
        } else if ((to == 0 || to == 21 || to == 18)
                && gameplan[0] == gameplan[21] && gameplan[21] == gameplan[18]) {
            return true;
        } else if ((to == 1 || to == 22 || to == 19)
                && gameplan[1] == gameplan[22] && gameplan[22] == gameplan[19]) {
            return true;
        } else if ((to == 2 || to == 23 || to == 20)
                && gameplan[2] == gameplan[23] && gameplan[23] == gameplan[20]) {
            return true;
        } else if ((to == 21 || to == 22 || to == 23)
                && gameplan[21] == gameplan[22] && gameplan[22] == gameplan[23]) {
            return true;
        } else if ((to == 3 || to == 4 || to == 5)
                && gameplan[3] == gameplan[4] && gameplan[4] == gameplan[5]) {
            return true;
        } else if ((to == 9 || to == 10 || to == 11)
                && gameplan[9] == gameplan[10] && gameplan[10] == gameplan[11]) {
            return true;
        } else if ((to == 15 || to == 16 || to == 17)
                && gameplan[15] == gameplan[16] && gameplan[16] == gameplan[17]) {
            return true;
        }
        return false;
    }

    /**
     * Request to remove a marker for the selected player.
     * Returns true if the marker where successfully removed
     */
    func remove(From: Int, color: Int) -> Bool{
        if (gameplan[From] == color) {
            gameplan[From] = NineMenMorrisRules.EMPTY_SPACE;
            if(color == NineMenMorrisRules.RED_MARKER){
                activeReds-=1
            }else if(color == NineMenMorrisRules.BLUE_MARKER){
                activeBlues-=1
            }
            return true
        } else{ return false}
    }
    /*
     * Returns true if the selected player can't move anywhere
     */
    func winNoMoves(color: Int, from: Int) -> Bool{
        /*
         * The game board positions
         *
         * 03           06           09
         *     02       05       08
         *         01   04   07
         * 24  23  22        10  11  12
         *         19   16   13
         *     20       17       14
         * 21           18           15
         *
         */
        
        switch (from) {
        case 0:
            return (gameplan[3] == color && gameplan[21] == color)
        case 1:
            return (gameplan[4] == color && gameplan[22] == color)
        case 2:
            return (gameplan[5] == color && gameplan[23] == color)
        case 3:
            return (gameplan[0] == color && gameplan[6] == color && gameplan[4] == color)
        case 4:
            return (gameplan[3] == color && gameplan[5] == color && gameplan[1] == color && gameplan[7] == color)
        case 5:
            return (gameplan[2] == color && gameplan[4] == color && gameplan[8] == color)
        case 6:
            return (gameplan[3] == color && gameplan[9] == color)
        case 7:
            return (gameplan[4] == color && gameplan[10] == color)
        case 8:
            return (gameplan[5] == color && gameplan[11] == color)
        case 9:
            return (gameplan[10] == color && gameplan[6] == color && gameplan[12] == color)
        case 10:
            return (gameplan[9] == color && gameplan[11] == color && gameplan[7] == color && gameplan[13] == color)
        case 11:
            return (gameplan[10] == color && gameplan[14] == color && gameplan[8] == color)
        case 12:
            return (gameplan[15] == color && gameplan[9] == color)
        case 13:
            return (gameplan[10] == color && gameplan[16] == color)
        case 14:
            return (gameplan[11] == color && gameplan[17] == color)
        case 15:
            return (gameplan[12] == color && gameplan[16] == color && gameplan[18] == color)
        case 16:
            return (gameplan[13] == color && gameplan[15] == color && gameplan[19] == color && gameplan[17] == color)
        case 17:
            return (gameplan[16] == color && gameplan[14] == color && gameplan[20] == color)
        case 18:
            return (gameplan[15] == color && gameplan[21] == color)
        case 19:
            return (gameplan[16] == color && gameplan[22] == color)
        case 20:
            return (gameplan[17] == color && gameplan[23] == color)
        case 21:
            return (gameplan[0] == color && gameplan[18] == color && gameplan[22] == color)
        case 22:
            return (gameplan[21] == color && gameplan[1] == color && gameplan[19] == color && gameplan[23] == color)
        case 23:
            return (gameplan[2] == color && gameplan[20] == color && gameplan[22] == color)
        default:
            return false;
        }
    }

    /**
     *  Returns true if the selected player have less than three markers left.
     */
    func win(color: Int) -> Bool{
        if(color == NineMenMorrisRules.BLUE_MARKER){
            if(activeBlues < 3){
                gameIsActive = false
                return true
            }
        }else{
            if(activeReds < 3){
                gameIsActive = false
                return true
            }
        }
        return false
    }

    /**
     * Returns EMPTY_SPACE = 0 BLUE_MARKER = 4 READ_MARKER = 5
     */
    func board(From: Int) -> Int {
        return gameplan[From];
    }
    
    /**
     * Check whether this is a legal move.
     */
    private func isValidMove(to : Int, from: Int) -> Bool{
        
        if(self.gameplan[to] != NineMenMorrisRules.EMPTY_SPACE){ return false }
        switch (to) {
        case 0:
            return (from == 3 || from == 21);
        case 1:
            return (from == 4 || from == 22);
        case 2:
            return (from == 5 || from == 23);
        case 3:
            return (from == 0 || from == 6 || from == 4);
        case 4:
            return (from == 3 || from == 5 || from == 1 || from == 7);
        case 5:
            return (from == 2 || from == 4 || from == 8);
        case 6:
            return (from == 3 || from == 9);
        case 7:
            return (from == 4 || from == 10);
        case 8:
            return (from == 5 || from == 11);
        case 9:
            return (from == 10 || from == 6 || from == 12);
        case 10:
            return (from == 9 || from == 11 || from == 7 || from == 13);
        case 11:
            return (from == 10 || from == 14 || from == 8);
        case 12:
            return (from == 15 || from == 9);
        case 13:
            return (from == 10 || from == 16);
        case 14:
            return (from == 11 || from == 17);
        case 15:
            return (from == 12 || from == 16 || from == 18);
        case 16:
            return (from == 13 || from == 15 || from == 19 || from == 17);
        case 17:
            return (from == 16 || from == 14 || from == 20);
        case 18:
            return (from == 15 || from == 21);
        case 19:
            return (from == 16 || from == 22);
        case 20:
            return (from == 17 || from == 23);
        case 21:
            return (from == 0 || from == 18 || from == 22);
        case 22:
            return (from == 21 || from == 1 || from == 19 || from == 23);
        case 23:
            return (from == 2 || from == 20 || from == 22);
        default:
            return false;
        }
    }
    
    func printBoard() -> Void{
        print("     ",gameplan[2], " ", gameplan[5], " ", gameplan[8])
        print("     ",gameplan[1], " ", gameplan[4], " ", gameplan[7])
        print("     ",gameplan[0], " ", gameplan[3], " ", gameplan[6])
        print(gameplan[23], " ", gameplan[22], " ", gameplan[21], " ", gameplan[9], " ", gameplan[10], " ", gameplan[11])
        print("     ",gameplan[18], " ", gameplan[15], " ", gameplan[12])
        print("     ",gameplan[19], " ", gameplan[16], " ", gameplan[13])
        print("     ",gameplan[20], " ", gameplan[17], " ", gameplan[14])
        print()
    }
    
    func startNewGame(){
        gameplan = Array(repeating: 0, count: 25) // zeroes
        bluemarker = 4
        redmarker = 4
        activeReds = 0
        activeBlues = 0
        gameIsActive = true
        //bluemarker = 9;
        //redmarker = 9;
        turn = 0
        turn = rand()
    }
    
    func saveGame() -> Void{
        var toBeSaved = nineMen()
        toBeSaved.gameplan = gameplan
        toBeSaved.activeBlues = activeBlues
        toBeSaved.activeReds = activeReds
        toBeSaved.bluemarker = bluemarker
        toBeSaved.redmarker = redmarker
        toBeSaved.turn = turn
        save(toBeSaved: toBeSaved)
    }
    
    func oldGame() -> Void{
        loadOldGame()
    }
    
    private func loadOldGame() -> Void{
        let oldData = getOldData()
        gameplan = oldData.gameplan!
        activeReds = oldData.activeReds!
        activeBlues = oldData.activeBlues!
        bluemarker = oldData.bluemarker!
        redmarker = oldData.redmarker!
        turn = oldData.turn!
        gameIsActive = true
        //if (nineMen{}) == oldData{
            
        /*else{
            gameplan = oldData.gameplan!
            activeReds = oldData.activeReds!
            activeBlues = oldData.activeBlues!
            bluemarker = oldData.bluemarker!
            redmarker = oldData.redmarker!
            turn = oldData.turn!
        }*/
    }
    
    private func save(toBeSaved: nineMen) -> Void{
        print("Saving data to file")
        if let encoded = try? JSONEncoder().encode(toBeSaved) {
            UserDefaults.standard.set(encoded, forKey: key)
        }else{
            print("Something went wrong when saving the data")
        }
    }
    private func getOldData() -> nineMen{
        var result = nineMen()
        if let data = UserDefaults.standard.data(forKey: key) {
            if let decodedGame = try? JSONDecoder().decode(nineMen.self, from: data) {
                result = decodedGame
            }
        }else{
            print("Something went wrong loading old data. Returning empty array")
        }
        return result
    }
    
}
