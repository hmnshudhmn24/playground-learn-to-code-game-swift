import PlaygroundSupport
import SpriteKit
import GameplayKit

class GameScene: SKScene {

    var player: SKSpriteNode!
    var goal: SKSpriteNode!
    var level = 0
    var instructionsLabel: SKLabelNode!

    override func didMove(to view: SKView) {
        backgroundColor = .white
        setupLevel()
    }

    func setupLevel() {
        removeAllChildren()

        instructionsLabel = SKLabelNode(text: "Move to the green goal using Swift code!")
        instructionsLabel.fontSize = 20
        instructionsLabel.fontColor = .black
        instructionsLabel.position = CGPoint(x: size.width/2, y: size.height - 60)
        addChild(instructionsLabel)

        player = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: 100, y: 100)
        player.name = "player"
        addChild(player)

        goal = SKSpriteNode(color: .green, size: CGSize(width: 50, height: 50))
        goal.position = CGPoint(x: 400, y: 400)
        goal.name = "goal"
        addChild(goal)
    }

    func movePlayer(direction: String) {
        var moveAction: SKAction?

        switch direction {
        case "up":
            moveAction = SKAction.moveBy(x: 0, y: 50, duration: 0.3)
        case "down":
            moveAction = SKAction.moveBy(x: 0, y: -50, duration: 0.3)
        case "left":
            moveAction = SKAction.moveBy(x: -50, y: 0, duration: 0.3)
        case "right":
            moveAction = SKAction.moveBy(x: 50, y: 0, duration: 0.3)
        default:
            break
        }

        if let action = moveAction {
            player.run(action) {
                self.checkForWin()
            }
        }
    }

    func checkForWin() {
        if player.frame.intersects(goal.frame) {
            let winLabel = SKLabelNode(text: "🎉 You Win!")
            winLabel.fontSize = 36
            winLabel.fontColor = .purple
            winLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
            addChild(winLabel)
        }
    }
}

// MARK: - Control Functions for Playground
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 500, height: 500))
let scene = GameScene(size: CGSize(width: 500, height: 500))
scene.scaleMode = .aspectFill
sceneView.presentScene(scene)
PlaygroundSupport.PlaygroundPage.current.liveView = sceneView

func move(_ direction: String) {
    scene.movePlayer(direction: direction)
}
