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
    
    var blueIsPressed = false
    var redIsPressed = false
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
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchedNode = self.atPoint(touch.location(in: self))
            if(game.whosTurn() == 1 && touchedNode.name == "bluePlayer"){
                let location = touch.location(in: self)
                blueIsPressed = true
                bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                /*
                 Testcase for copying markers
                 */
                if(game.getBlueMarkersLeft() >= 0)
                {
                    let bluePlayercpy = bluePlayer.copy() as! SKSpriteNode
                    addChild(bluePlayercpy)
                }
            }
            else if(game.whosTurn() == 2 && touchedNode.name == "redPlayer"){
                let location = touch.location(in: self)
                redIsPressed = true
                redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                /*
                 Testcase for copying markers
                 */
                if(game.getRedMarkersLeft() >= 0)
                {
                    let redPlayercpy = redPlayer.copy() as! SKSpriteNode
                    addChild(redPlayercpy)
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            if(game.whosTurn() == 1){
                if(blueIsPressed){
                    let location = touch.location(in: self)
                    bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
            }else if(game.whosTurn() == 2){
                if(redIsPressed){
                    let location = touch.location(in: self)
                    redPlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
                    redPlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            for node in emptyNodes{
                let location = touch.location(in: self)
                if(location.x <= (node.position.x+25) && location.x >= (node.position.x-25) && location.y <= (node.position.y+25) && location.y >= (node.position.y-25)){
                    if(game.legalMove(To: Int(node.name!)!, From: 0, color: game.whosTurn())){
                        if(game.whosTurn() == 1){
                            blueIsPressed = false
                            bluePlayer.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                            bluePlayer.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                            //bluePlayer.isPaused = true
                        }else if(game.whosTurn() == 2){
                            redIsPressed = false
                            redPlayer.run(SKAction.moveTo(x: node.position.x, duration: 0.0))
                            redPlayer.run(SKAction.moveTo(y: node.position.y, duration: 0.0))
                            //redPlayer.isPaused = true
                        }
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
}
