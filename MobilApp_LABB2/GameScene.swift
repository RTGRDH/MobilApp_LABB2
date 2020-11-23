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
    var emptyNodes:[SKNode] = [SKNode]()
    var bluePlayer = SKSpriteNode()
    var redPlayer = SKSpriteNode()
    let game = NineMenMorrisRules()
    var blueMarkersLeft = SKLabelNode()
    var redMarkersLeft = SKLabelNode()
    
    var bluePlaced: [SKSpriteNode] = [SKSpriteNode]()
    var redPlaced: [SKSpriteNode] = [SKSpriteNode]()

    var letBlueRemove = false
    var letRedRemove = false
    var blueIsPressed = false
    var redIsPressed = false
    
    struct startPos{
        let x: CGFloat
        let y: CGFloat
    }
    
    var blueStart = startPos(x: 0.0, y: 0.0)
    var redStart = startPos(x: 0.0, y: 0.0)
    override func didMove(to view: SKView) {
        bluePlayer = self.childNode(withName: "bluePlayer") as! SKSpriteNode
        redPlayer = self.childNode(withName: "redPlayer") as! SKSpriteNode
        for node in 1...24
        {
            emptyNodes.append(self.childNode(withName: String(node))!)
        }
        blueMarkersLeft = self.childNode(withName: "blueMarkersLeft") as! SKLabelNode
        redMarkersLeft = self.childNode(withName: "redMarkersLeft") as! SKLabelNode
        blueMarkersLeft.text = "9"
        redMarkersLeft.text = "9"
        blueStart = startPos(x: bluePlayer.position.x, y: bluePlayer.position.y)
        redStart = startPos(x: redPlayer.position.x, y: redPlayer.position.y)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if(letBlueRemove){
                /*let touchedNode = self.atPoint(touch.location(in: self))
                if(touchedNode.name != "bluePlayer" && touchedNode.name != "redPlayer"){
                    if(game.remove(From: Int(touchedNode.name!)!, color: 2)){
                        letBlueRemove = false
                    }
                }*/
                letBlueRemove = false
            }else if(letRedRemove){
                letRedRemove = false
            }else{
                let touchedNode = self.atPoint(touch.location(in: self))
                if(game.whosTurn() == 1 && touchedNode.name == "bluePlayer"){
                    let location = touch.location(in: self)
                    blueIsPressed = true
                    bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }else if(game.whosTurn() == 2 && touchedNode.name == "redPlayer"){
                    let location = touch.location(in: self)
                    redIsPressed = true
                    redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if(game.whosTurn() == 1 && blueIsPressed){
                let location = touch.location(in: self)
                bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                
            }else if(game.whosTurn() == 2 && redIsPressed){
                let location = touch.location(in: self)
                redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for _ in touches{
            for node in emptyNodes{
                //bugg atm
                if(node.name == "24"){
                    blueIsPressed = false
                    bluePlayer.run(SKAction.moveTo(x: blueStart.x, duration: 0.0))
                    bluePlayer.run(SKAction.moveTo(y: blueStart.y, duration: 0.0))
                    break
                }
                if(blueIsPressed){
                    if(bluePlayer.position.x <= (node.position.x+25) && bluePlayer.position.x >= (node.position.x-25) && bluePlayer.position.y <= (node.position.y+25) && bluePlayer.position.y >= (node.position.y-25)){
                        if(game.getBlueMarkersLeft() > 0){
                            if(game.legalMove(To: Int(node.name!)!, From: 0, color: 1)){
                                let placed = bluePlayer.copy() as! SKSpriteNode
                                addChild(placed)
                                bluePlaced.append(placed)
                                bluePlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                bluePlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                moveBlueToStart()
                                if(game.remove(to: Int(node.name!)!)){
                                    print("MILL BLÅ")
                                    letBlueRemove = true
                                }
                            }else{
                                moveBlueToStart()
                            }
                        }else{
                            print("Slut med drag")
                        }
                        //Fixa annan kod här
                        /*print("Lyckat")
                        blueIsPressed = false
                        bluePlayer.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                        bluePlayer.run(SKAction.moveTo(y: node.position.y, duration: 0.0))*/
                        break
                    }else{
                        continue
                    }
                }else if(redIsPressed){
                    if(redPlayer.position.x <= (node.position.x+25) && redPlayer.position.x >= (node.position.x-25) && redPlayer.position.y <= (node.position.y+25) && redPlayer.position.y >= (node.position.y-25)){
                        if(game.getRedMarkersLeft() > 0){
                            if(game.legalMove(To: Int(node.name!)!, From: 0, color: 2)){
                                let placed = redPlayer.copy() as! SKSpriteNode
                                addChild(placed)
                                redPlaced.append(placed)
                                redPlaced.last?.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                                redPlaced.last?.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                                moveRedToStart()
                                if(game.remove(to: Int(node.name!)!)){
                                    print("MILL RÖD")
                                    letRedRemove = true
                                }
                            }else{
                                moveRedToStart()
                            }
                        }else{
                            print("Slut med drag")
                        }
                        //Fixa annan kod här
                        /*print("Lyckat")
                        blueIsPressed = false
                        bluePlayer.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                        bluePlayer.run(SKAction.moveTo(y: node.position.y, duration: 0.0))*/
                        break
                    }else{
                        continue
                    }
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        blueMarkersLeft.text = String(game.getBlueMarkersLeft())
        redMarkersLeft.text = String(game.getRedMarkersLeft())
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
}
