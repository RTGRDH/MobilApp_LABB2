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
    override func didMove(to view: SKView) {
        bluePlayer = self.childNode(withName: "bluePlayer") as! SKSpriteNode
        redPlayer = self.childNode(withName: "redPlayer") as! SKSpriteNode
        for node in 1...24
        {
            emptyNodes.append(self.childNode(withName: String(node))!)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            //bluePlayer.run(SKAction.moveBy(x: location.x, y: location.y, duration: 0.2))
            bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
            bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            //bluePlayer.run(SKAction.moveBy(x: location.x, y: location.y, duration: 0.2))
            bluePlayer.run(SKAction.moveTo(x: location.x, duration: 0.0))
            bluePlayer.run(SKAction.moveTo(y: location.y, duration: 0.0))
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            print(emptyNodes[1].name!)
            let location = touch.location(in: self)
            var node = emptyNodes[1]
            if(location.x <= (node.position.x+10) && location.x >= (node.position.x-10) && location.y <= (node.position.y+10) && location.y >= (node.position.y-10)){
                   print("Lyckades")
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
