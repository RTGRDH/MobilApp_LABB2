//
//  GameScene.swift
//  MobilApp_LABB2
//
//  Created by Ernst on 2020-11-22.
//
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
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
    var board = SKSpriteNode(imageNamed: "board")
    var emptyNodes:[SKNode] = [SKNode]()
    var bluePlayer = SKSpriteNode()
    var redPlayer = SKSpriteNode()
    var game = NineMenMorrisRules()
    var blueMarkersLeft = SKLabelNode()
    var redMarkersLeft = SKLabelNode()
    
    var bluePlaced: [SKSpriteNode] = [SKSpriteNode]()
    var redPlaced: [SKSpriteNode] = [SKSpriteNode]()
    var whosTurnLabel = SKLabelNode()

    var letBlueRemove = false
    var letRedRemove = false
    var blueIsPressed = false
    var redIsPressed = false
    var allPlaced = false
    
    var blueIndex = 25
    var redIndex = 25
    
    struct startPos{
        let x: CGFloat
        let y: CGFloat
    }
    var blueStart = startPos(x: 0.0, y: 0.0)
    var redStart = startPos(x: 0.0, y: 0.0)
    override func didMove(to view: SKView) {
        self.board.size = self.frame.size
        board.isPaused = true
        bluePlayer = self.childNode(withName: "bluePlayer") as! SKSpriteNode
        redPlayer = self.childNode(withName: "redPlayer") as! SKSpriteNode
        whosTurnLabel = self.childNode(withName: "whosTurn") as! SKLabelNode
        for node in 1...24
        {
            emptyNodes.append(self.childNode(withName: String(node-1))!)
            emptyNodes[node-1].isPaused = true
        }
        blueMarkersLeft = self.childNode(withName: "blueMarkersLeft") as! SKLabelNode
        redMarkersLeft = self.childNode(withName: "redMarkersLeft") as! SKLabelNode
        blueMarkersLeft.text = "9"
        redMarkersLeft.text = "9"
        blueStart = startPos(x: bluePlayer.position.x, y: bluePlayer.position.y)
        redStart = startPos(x: redPlayer.position.x, y: redPlayer.position.y)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.printBoard()
        if(game.getBlueMarkersLeft() == 0 && game.getRedMarkersLeft() == 0){
            allPlaced = true
        }
        if(game.getGameState()){
            guard let touch = touches.first else{
                return
            }
            let location = touch.location(in: self)
            if(letBlueRemove || letRedRemove){
                if(letBlueRemove){
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(touchedNode.name?.dropFirst(2) == "R" || touchedNode.name?.dropFirst() == "R"){
                        let remove = Int(touchedNode.name!.dropLast())!
                        if(game.remove(From: remove, color: NineMenMorrisRules.RED_MARKER)){
                            let index = redPlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                            let removedPiece = redPlaced[index!]
                            removedPiece.removeFromParent()
                            redPlaced.remove(at: index!)
                            letBlueRemove = false
                        }
                    }
                }else if(letRedRemove){
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(touchedNode.name?.dropFirst(2) == "B" || touchedNode.name?.dropFirst() == "B"){
                        let remove = Int(touchedNode.name!.dropLast())!
                        if(game.remove(From: remove, color: NineMenMorrisRules.BLUE_MARKER)){
                            let index = bluePlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                            let removedPiece = bluePlaced[index!]
                            removedPiece.removeFromParent()
                            bluePlaced.remove(at: index!)
                            letRedRemove = false
                        }
                    }
                }
            }else{
                if(!allPlaced){
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(game.whosTurn() == 1 && touchedNode.name == "bluePlayer"){
                        blueIsPressed = true
                        bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                        bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                    }else if(game.whosTurn() == 2 && touchedNode.name == "redPlayer"){
                        redIsPressed = true
                        redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                        redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                    }
                }else{
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(game.whosTurn() == 1 && touchedNode.name?.dropFirst(2) == "B" || (game.whosTurn() == 1 && touchedNode.name?.dropFirst() == "B")){
                        blueIndex = bluePlaced.firstIndex(of: touchedNode as! SKSpriteNode)!
                        blueIsPressed = true
                        let index = bluePlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                        bluePlaced[index!].run(SKAction.moveTo(x: location.x, duration: 0.0))
                        bluePlaced[index!].run(SKAction.moveTo(y: location.y, duration: 0.0))
                    }else if(game.whosTurn() == 2 && touchedNode.name?.dropFirst(2) == "R" || (game.whosTurn() == 2 && touchedNode.name?.dropFirst() == "R")){
                        redIndex = redPlaced.firstIndex(of: touchedNode as! SKSpriteNode)!
                        redIsPressed = true
                        let index = redPlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                        redPlaced[index!].run(SKAction.moveTo(x: location.x, duration: 0.0))
                        redPlaced[index!].run(SKAction.moveTo(y: location.y, duration: 0.0))
                    }
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            if(!allPlaced){
                if(game.whosTurn() == 1 && blueIsPressed){
                    bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                    
                }else if(game.whosTurn() == 2 && redIsPressed){
                    redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
            }else{
                if(game.whosTurn() == 1 && blueIsPressed){
                    let blue = bluePlaced[blueIndex]
                    blue.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    blue.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }else if(game.whosTurn() == 2 && redIsPressed){
                    let red = redPlaced[redIndex]
                    red.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    red.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if(!allPlaced){
                for node in emptyNodes{
                    if(node.name == "23"){
                        if(blueIsPressed){
                            if(isNearNode(player: bluePlayer, node: node)){
                                if(game.legalMove(To: 23, From: 25, color: NineMenMorrisRules.BLUE_MOVES)){
                                    blueIsPressed = false
                                    let placed = bluePlayer.copy() as! SKSpriteNode
                                    placed.name = node.name! + "B"
                                    addChild(placed)
                                    bluePlaced.append(placed)
                                    bluePlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    bluePlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    moveBlueToStart()
                                }else{
                                    blueIsPressed = false
                                    moveBlueToStart()
                                }
                            }else{
                                blueIsPressed = false
                                moveBlueToStart()
                            }
                        }else if(redIsPressed){
                            if(isNearNode(player: redPlayer, node: node)){
                                if(game.legalMove(To: 23, From: 25, color: NineMenMorrisRules.RED_MOVES)){
                                    redIsPressed = false
                                    let placed = redPlayer.copy() as! SKSpriteNode
                                    placed.name = node.name! + "R"
                                    addChild(placed)
                                    redPlaced.append(placed)
                                    redPlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    redPlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    moveRedToStart()
                                }else{
                                    redIsPressed = false
                                    moveRedToStart()
                                }
                            }else{
                                redIsPressed = false
                                moveRedToStart()
                            }
                        }
                    }
                    if(blueIsPressed){
                        if(isNearNode(player: bluePlayer, node: node)){
                                if(game.legalMove(To: Int(node.name!)!, From: 25, color: NineMenMorrisRules.BLUE_MOVES)){
                                    blueIsPressed = false
                                    let placed = bluePlayer.copy() as! SKSpriteNode
                                    placed.name = node.name! + "B"
                                    print(placed.name!)
                                    addChild(placed)
                                    bluePlaced.append(placed)
                                    bluePlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    bluePlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    moveBlueToStart()
                                    if(game.remove(to: Int(node.name!)!)){
                                        letBlueRemove = true
                                    }
                                }else{
                                    blueIsPressed = false
                                    moveBlueToStart()
                                }
                        }else{
                            continue
                        }
                    }else if(redIsPressed){
                        if(isNearNode(player: redPlayer, node: node)){
                                if(game.legalMove(To: Int(node.name!)!, From: 25, color: NineMenMorrisRules.RED_MOVES)){
                                    redIsPressed = false
                                    let placed = redPlayer.copy() as! SKSpriteNode
                                    placed.name = node.name! + "R"
                                    print(placed.name!)
                                    addChild(placed)
                                    redPlaced.append(placed)
                                    redPlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    redPlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    moveRedToStart()
                                    if(game.remove(to: Int(node.name!)!)){
                                        letRedRemove = true
                                    }
                                }else{
                                    redIsPressed = false
                                    moveRedToStart()
                                }
                        }else{
                            continue
                        }
                    }
                }
            }else{
                if(blueIsPressed){
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(touchedNode.name?.dropFirst(2) == "B" || touchedNode.name?.dropFirst() == "B"){
                        let index = bluePlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                        for node in emptyNodes{
                            if(node.name == "23"){
                                let from = Int((bluePlaced[index!].name?.dropLast())!)!
                                if(isNearNodeArr(placed: bluePlaced, index: index!, node: node)){
                                    if(game.legalMove(To: Int(node.name!)!, From: from, color: NineMenMorrisRules.BLUE_MOVES)){
                                        blueIsPressed = false
                                        bluePlaced[index!].name = node.name! + "B"
                                        bluePlaced[index!].run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                        bluePlaced[index!].run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                        if(game.remove(to: Int(node.name!)!)){
                                            print("MILL BLÅ")
                                            letBlueRemove = true
                                        }
                                    }else{
                                        moveToRecentNode(placed: bluePlaced, index: index!)
                                        blueIsPressed = false
                                    }
                                }else{
                                    blueIsPressed = false
                                    moveToRecentNode(placed: bluePlaced, index: index!)
                                }
                            }
                            if(isNearNodeArr(placed: bluePlaced, index: index!, node: node)){
                                if(game.legalMove(To: Int(node.name!)!, From: Int((bluePlaced[index!].name?.dropLast())!)!, color: NineMenMorrisRules.BLUE_MOVES)){
                                    blueIsPressed = false
                                    bluePlaced[index!].name = node.name! + "B"
                                    bluePlaced[index!].run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    bluePlaced[index!].run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    if(game.remove(to: Int(node.name!)!)){
                                        print("MILL BLÅ")
                                        letBlueRemove = true
                                    }
                                    break
                                }else{
                                    moveToRecentNode(placed: bluePlaced, index: index!)
                                    blueIsPressed = false
                                    break
                                }
                            }
                        }
                    }
                }else if(redIsPressed){
                    let touchedNode = self.atPoint(touch.location(in: self))
                    if(touchedNode.name?.dropFirst(2) == "R" || touchedNode.name?.dropFirst() == "R"){
                        let index = redPlaced.firstIndex(of: touchedNode as! SKSpriteNode)
                        for node in emptyNodes{
                            if(node.name == "23"){
                                let from = Int((redPlaced[index!].name?.dropLast())!)!
                                if(isNearNodeArr(placed: redPlaced, index: index!, node: node)){
                                    if(game.legalMove(To: Int(node.name!)!, From: from, color: NineMenMorrisRules.RED_MOVES)){
                                        redIsPressed = false
                                        redPlaced[index!].run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                        redPlaced[index!].run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                        if(game.remove(to: Int(node.name!)!)){
                                            print("Mill röd")
                                            letRedRemove = true
                                        }
                                    }else{
                                        moveToRecentNode(placed: redPlaced, index: index!)
                                        redIsPressed = false
                                    }
                                }else{
                                    redIsPressed = false
                                    moveToRecentNode(placed: redPlaced, index: index!)
                                }
                            }
                            if(isNearNodeArr(placed: redPlaced, index: index!, node: node)){
                                if(game.legalMove(To: Int(node.name!)!, From: Int((redPlaced[index!].name?.dropLast())!)!, color: NineMenMorrisRules.RED_MOVES)){
                                    print(node.name!)
                                    redIsPressed = false
                                    redPlaced[index!].name = node.name! + "R"
                                    redPlaced[index!].run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                    redPlaced[index!].run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                    if(game.remove(to: Int(node.name!)!)){
                                        print("MILL RÖD")
                                        letRedRemove = true
                                    }
                                    break
                                }else{
                                    moveToRecentNode(placed: redPlaced, index: index!)
                                    redIsPressed = false
                                    break
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(allPlaced){
            if(game.win(color: NineMenMorrisRules.BLUE_MARKER)){
                whosTurnLabel.text = "Red Wins!"
                whosTurnLabel.fontColor = .red
            }else if(game.win(color: NineMenMorrisRules.RED_MARKER)){
                whosTurnLabel.text = "Blue Wins!"
                whosTurnLabel.fontColor = .blue
            }
            updateUI()
        }
        else{
            updateUI()
        }
    }
    
    private func updateUI() -> Void{
        if(game.getGameState()){
            if(allPlaced){
                bluePlayer.isPaused = true
                redPlayer.isPaused = true
                blueMarkersLeft.text = "0"
                redMarkersLeft.text = "0"
            }else{
                blueMarkersLeft.text = String(game.getBlueMarkersLeft())
                redMarkersLeft.text = String(game.getRedMarkersLeft())
            }
            if(!letRedRemove && !letBlueRemove){
                if(game.whosTurn() == 1){
                    whosTurnLabel.text = "Blue's turn"
                    whosTurnLabel.fontColor = .blue
                }else{
                    whosTurnLabel.text = "Red's turn"
                    whosTurnLabel.fontColor = .red
                }
            }else{
                if(letRedRemove){
                    whosTurnLabel.text = "Remove Blue"
                    whosTurnLabel.fontColor = .red
                }else{
                    whosTurnLabel.text = "Remove Red"
                    whosTurnLabel.fontColor = .blue
                }
            }
        }
    }
    
    private func moveToRecentNode(placed: [SKSpriteNode], index: Int) -> Void{
        let temp = placed[index]
        let nodePos = Int((temp.name?.dropLast())!)!
        let tempNode = emptyNodes[nodePos]
        print("Moving back to : ", tempNode.name!)
        placed[index].run(SKAction.moveTo(x: tempNode.position.x, duration: 0.0))
        placed[index].run(SKAction.moveTo(y: tempNode.position.y, duration: 0.0))
    }
    
    private func isNearNodeArr(placed: [SKSpriteNode], index: Int, node: SKNode) -> Bool{
        if(placed[index].position.x <= (node.position.x+25) && placed[index].position.x >= (node.position.x-25) && placed[index].position.y <= (node.position.y+25) && placed[index].position.y >= (node.position.y-25)){
            return true
        }
        return false
    }
    
    private func isNearNode(player: SKSpriteNode, node: SKNode) -> Bool{
        if(player.position.x <= (node.position.x+25) && player.position.x >= (node.position.x-25) && player.position.y <= (node.position.y+25) && player.position.y >= (node.position.y-25)){
            return true
        }
        return false
    }
    
    private func moveBlueToStart() -> Void{
        blueIsPressed = false
        bluePlayer.run(SKAction.moveTo(x: blueStart.x, duration: 0.0))
        bluePlayer.run(SKAction.moveTo(y: blueStart.y, duration: 0.0))
    }
    private func moveRedToStart() -> Void{
        redIsPressed = false
        redPlayer.run(SKAction.moveTo(x: redStart.x, duration: 0.0))
        redPlayer.run(SKAction.moveTo(y: redStart.y, duration: 0.0))
    }
    
    private func startNewGame() -> Void{
        blueMarkersLeft.text = "9"
        redMarkersLeft.text = "9"
        for blue in bluePlaced{
            blue.removeFromParent()
        }
        for red in redPlaced{
            red.removeFromParent()
        }
        bluePlaced.removeAll()
        redPlaced.removeAll()
        bluePlayer.isPaused = false
        redPlayer.isPaused = false
        moveBlueToStart()
        moveRedToStart()
        game = NineMenMorrisRules()
    }
}
