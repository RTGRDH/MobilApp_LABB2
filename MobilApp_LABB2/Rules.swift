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

        if ((to == 1 || to == 4 || to == 7) && gameplan[1] == gameplan[4]
                && gameplan[4] == gameplan[7]) {
            return true;
        } else if ((to == 2 || to == 5 || to == 8)
                && gameplan[2] == gameplan[5] && gameplan[5] == gameplan[8]) {
            return true;
        } else if ((to == 3 || to == 6 || to == 9)
                && gameplan[3] == gameplan[6] && gameplan[6] == gameplan[9]) {
            return true;
        } else if ((to == 7 || to == 10 || to == 13)
                && gameplan[7] == gameplan[10] && gameplan[10] == gameplan[13]) {
            return true;
        } else if ((to == 8 || to == 11 || to == 14)
                && gameplan[8] == gameplan[11] && gameplan[11] == gameplan[14]) {
            return true;
        } else if ((to == 9 || to == 12 || to == 15)
                && gameplan[9] == gameplan[12] && gameplan[12] == gameplan[15]) {
            return true;
        } else if ((to == 13 || to == 16 || to == 19)
                && gameplan[13] == gameplan[16] && gameplan[16] == gameplan[19]) {
            return true;
        } else if ((to == 14 || to == 17 || to == 20)
                && gameplan[14] == gameplan[17] && gameplan[17] == gameplan[20]) {
            return true;
        } else if ((to == 15 || to == 18 || to == 21)
                && gameplan[15] == gameplan[18] && gameplan[18] == gameplan[21]) {
            return true;
        } else if ((to == 1 || to == 22 || to == 19)
                && gameplan[1] == gameplan[22] && gameplan[22] == gameplan[19]) {
            return true;
        } else if ((to == 2 || to == 23 || to == 20)
                && gameplan[2] == gameplan[23] && gameplan[23] == gameplan[20]) {
            return true;
        } else if ((to == 3 || to == 24 || to == 21)
                && gameplan[3] == gameplan[24] && gameplan[24] == gameplan[21]) {
            return true;
        } else if ((to == 22 || to == 23 || to == 24)
                && gameplan[22] == gameplan[23] && gameplan[23] == gameplan[24]) {
            return true;
        } else if ((to == 4 || to == 5 || to == 6)
                && gameplan[4] == gameplan[5] && gameplan[5] == gameplan[6]) {
            return true;
        } else if ((to == 10 || to == 11 || to == 12)
                && gameplan[10] == gameplan[11] && gameplan[11] == gameplan[12]) {
            return true;
        } else if ((to == 16 || to == 17 || to == 18)
                && gameplan[16] == gameplan[17] && gameplan[17] == gameplan[18]) {
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

    /**
     *  Returns true if the selected player have less than three markers left.
     */
    func win(color: Int) -> Bool{
        var countMarker = 0;
        var count = 0;
        while (count < 23) {
            if (gameplan[count] != NineMenMorrisRules.EMPTY_SPACE && gameplan[count] == color) {
                countMarker+=1
            }
            count+=1;
        }
        if (bluemarker <= 0 && redmarker <= 0 && countMarker < 3)
        {
            gameIsActive = false
            return true
        }
        else
        {return false;}
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
}
