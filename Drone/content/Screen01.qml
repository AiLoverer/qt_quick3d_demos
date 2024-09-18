

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import Drone
import QtQuick3D 6.2
//import Quick3DAssets.Drones
import QtQuick3D.Helpers
import QtQuick.Particles
import QtQuick3D.Particles3D
import Quick3DAssets.Drones 1.0

Rectangle {
    id: mainWindow
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    //! [main properties]
    // Scaling helpper
    readonly property real px: 0.2 + Math.min(width, height) / 800
    // This is false until the first game has started
    property bool playingStarted: false
    // This is true whenever game is on
    property bool gameOn: false
    // Sizes of our 3D models
    readonly property real droneSize: 100
    readonly property real targetSize: 120
    // Playing time in seconds
    readonly property real gameTime: 60
    property real currentTime: 0
    // Amount of balls per game
    readonly property int gameDrones: 20
    property int currentBalls: 0
    // Scores
    property int score: 0
    property int timeBonus: 0
    property int ballsBonus: 0
    property int cameraViewTab: 0
    property int currentLevel: 0
    property int totalLevel: 3
    property var levelsInfo: []
    property string gameStateText: "START"
    property string gameStateTipImg: "images/playdrone.png"
    //! [main properties]

    Item {
        id: __materialLibrary__

        PrincipledMaterial {
            id: principledMaterial
            objectName: "New Material"
        }
    }
    // 设置焦点
    focus: true

    // 监听按键按下事件
    Keys.onReleased: (event)=> {
         if (event.key === Qt.Key_Tab) {
             cameraViewTab++;
             if(cameraViewTab == 2){
                  cameraViewTab = 0;
             }
             console.log("Tab key was pressed!");
             if(cameraViewTab == 0) {
                view3D.camera = viewCamera;
             }else if(cameraViewTab == 1){
                view3D.camera = droneCamera;
             }
         }else if(event.key === Qt.Key_Control) {
            droneModel.onkeyStrike()
         }
    }

    View3D {
        id: view3D
        anchors.fill: parent
        // environment: sceneEnvironment
        // SceneEnvironment {
        //     id: sceneEnvironment
        //     backgroundMode: SceneEnvironment.SkyBox
        //     probeExposure: 2
        //     lightProbe: Texture {
        //         source: "maps/OpenfootageNET_lowerAustria01-1024.hdr"
        //     }
        // }

        //! test
        // Model {
        //     id: testModel
        //     source: "#Cube"
        //     scale: Qt.vector3d(2, 2, 2)
        //     materials: DefaultMaterial {
        //         diffuseColor: Qt.rgba(0.4, 0.4, 0.4, 1.0)
        //     }

        //     PropertyAnimation{
        //         target: testModel
        //         property: "position"
        //         running: false
        //         from: droneModel.position
        //         to: Qt.vector3d(100,200,-300)
        //         duration: 5000
        //         loops: Animation.Infinite
        //     }
        // }


        //! test

        //! [view functions]
        function defineLevelStruct() {
            var levelInfo = {
                level: 0,  // 等级
                items: []  // 位置信息和分数
            };
            return levelInfo;
        }
        function initGameLevels() {
            var level1 = [{ "x": 0, "y": 100, "z": -100, "points": 10 },
                          { "x": -300, "y": 100, "z": -400, "points": 10 },
                          { "x": 300, "y": 100, "z": -400, "points": 10 },
                          { "x": -200, "y": 400, "z": -600, "points": 20 },
                          { "x": 0, "y": 400, "z": -600, "points": 20 },
                          { "x": 200, "y": 400, "z": -600, "points": 20 },
                          { "x": 0, "y": 700, "z": -600, "points": 30 }];
            var level2 = [{ "x": 0, "y": 100, "z": -1000, "points": 10 },
                          { "x": -600, "y": 100, "z": -400, "points": 10 },
                          { "x": 600, "y": 100, "z": -400, "points": 10 },
                          { "x": -400, "y": 400, "z": -800, "points": 20 },
                          { "x": 0, "y": 400, "z": -600, "points": 20 },
                          { "x": 400, "y": 400, "z": -600, "points": 20 },
                          { "x": 0, "y": 700, "z": -600, "points": 30 }];
            mainWindow.levelsInfo.push(level1);
            mainWindow.levelsInfo.push(level2);
            console.log("Game total level : " + mainWindow.levelsInfo.length);
        }

        function createLevel() {
            // Simple level of target items
            if(mainWindow.currentLevel < mainWindow.levelsInfo.length) {
                targetsNode.addTargets(mainWindow.levelsInfo[mainWindow.currentLevel])
                mainWindow.currentLevel++;

            }
            console.log("Create game level " + mainWindow.currentLevel);
        }

        function startGame() {
            droneModel.resetDrone();
            targetsNode.resetTargets();
            createLevel();

            currentBalls = gameDrones;
            gameOn = true;
            playingStarted = true;

            if(mainWindow.gameStateText === "START"){
                score = timeBonus = ballsBonus = 0;
            }else if(mainWindow.gameStateText === "NEXT") {

            }
        }

        function endGame() {
            if (targetsNode.currentTargets == 0) {
                // If we managed to get all targets down -> bonus points!
                timeBonus = mainWindow.currentTime;
                ballsBonus = currentBalls * 10;
            }

            gameOn = false;
            mainWindow.gameStateText = "START";
            mainWindow.gameStateTipImg = "images/gameover.png";
            mainWindow.currentLevel = 0;
            console.log("End Game !!!")
        }
        function nextLevel() {

            if(mainWindow.currentLevel >= mainWindow.levelsInfo.length) {
                view3D.endGame();
            }else {
                timeBonus = mainWindow.currentTime;
                ballsBonus = currentBalls * 10;

                mainWindow.gameStateText = "NEXT";
                mainWindow.gameStateTipImg = "images/pass.png";
                gameOn = false;
            }
        }

        //! [view functions]

        environment: SceneEnvironment {
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }

        camera: viewCamera
        // WasdController {
        //     controlledObject: droneCamera

        // }
        PerspectiveCamera {
            id: viewCamera
            x: -9.247
            y: -8434.228
            position: Qt.vector3d(0, 200, 800);
            z: 71.11844

            // Rotate camera a bit
            SequentialAnimation on eulerRotation.y {
                loops: Animation.Infinite
                NumberAnimation {
                    to: 2
                    duration: 2000
                    easing.type: Easing.InOutQuad
                }
                NumberAnimation {
                    to: -2
                    duration: 2000
                    easing.type: Easing.InOutQuad
                }
            }
        }

        //! [lights]
        PointLight {
            x: -106.732
            y: 237.612
            z: 18.70217
            eulerRotation.z: 0
            eulerRotation.y: 4.58366
            eulerRotation.x: -0
            castsShadow: true
            shadowMapQuality: Light.ShadowMapQualityHigh
            shadowFactor: 50
            quadraticFade: 2
            ambientColor: "#202020"
            brightness: mainWindow.gameOn ? 200 : 40
            Behavior on brightness {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }
            }
        }
       //! [lights]

        //! [ball handling]
        MouseArea {
            anchors.fill: parent
            enabled: mainWindow.gameOn && !droneModel.ballMoving
            onPressed: {
                droneModel.moveDrone(mouseX, mouseY);
            }
            onPositionChanged: {
                droneModel.moveDrone(mouseX, mouseY);
            }
            onReleased: {
                droneModel.throwDrone();
            }

        }
        //! [ball handling]


        //! [ball model]
        Drones {
            id: droneModel
            PerspectiveCamera {
                id: droneCamera
                x: -9.972
                y: 62.168
                pivot.x: 0
                pivot.z: 0
                pivot.y: 0
                eulerRotation.z: -0.00001
                z: 27.38598

                clipNear: 1
                clipFar: 10000
                eulerRotation.y: -0
            }
            property real directionX: 0
            property real directionY: 0
            // How many ms the ball flies
            readonly property real speed: 2000
            readonly property real ballScale: mainWindow.droneSize / 100
            property var moves: []
            readonly property int maxMoves: 5
            readonly property bool ballMoving: ballAnimation.running
            property vector3d enemyDroneSencePosition: Qt.vector3d(100, 600, -1000)
            //readonly property vector3d originRotation: droneModel.rotation
            //source: "#Sphere"
            scale: Qt.vector3d(ballScale, ballScale, ballScale)

            // materials: DefaultMaterial {
            //     diffuseMap: Texture {
            //         source: "images/ball.jpg"
            //     }
            //     normalMap: Texture {
            //         source: "images/ball_n.jpg"
            //     }
            //     bumpAmount: 1.0
            // }
            // modelMaterial: PrincipledMaterial {
            //     id: defaultMaterial_material
            //     objectName: "DefaultMaterial"
            //     baseColor: "red"
            // }
            modelMaterial.baseColor: "red"
            //! [ball model]

            //! [ball functions]
            function resetDrone() {
                moves = [];
                droneModel.x = 0;
                droneModel.y = mainWindow.droneSize/2;
                droneModel.z = 400;
                droneModel.eulerRotation.z = 0;
            }

            function moveDrone(posX, posY) {
                var pos = view3D.mapTo3DScene(Qt.vector3d(posX, posY, droneModel.z + mainWindow.droneSize));
                pos.y = Math.max(mainWindow.droneSize / 2, pos.y);
                var point = {"x": pos.x, "y": pos.y };
                moves.push(point);
                if (moves.length > maxMoves) moves.shift();
                // Apply position into ball model
                droneModel.x = pos.x;
                droneModel.y = pos.y;
            }

            function throwDrone() {
                mainWindow.currentBalls--;
                var moveX = 0;
                var moveY = 0;
                if (moves.length >= 2) {
                    var first = moves.shift();
                    var last = moves.pop();
                    moveX = last.x - first.x;
                    moveY = last.y - first.y;
                    if (moveY < 0) moveY = 0;
                }
                directionX = moveX * 20;
                directionY = moveY * 4;
                ballAnimation.start();
            }

            function onkeyStrike() {
                if(targetsNode.targets.length > 0) {
                    for (var i = 0; i < targetsNode.targets.length; ++i) {
                        var target = targetsNode.targets[i];
                        enemyDroneSencePosition = target.scenePosition;
                        console.log("enemyDroneSencePosition.x: " + enemyDroneSencePosition.x+ " y: " + enemyDroneSencePosition.y + " z: " +enemyDroneSencePosition.z)
                        break;
                    }
                    mainWindow.currentBalls--;
                    onekeyStrikeAnimation.start();
                }else {
                    console.log("Do not find any enemy drone !");
                }
            }

            //! [ball functions]

            //! [ball strike animations]
            PropertyAnimation{
                id: onekeyStrikeAnimation
                target: droneModel
                property: "position"
                running: false
                from: droneModel.position
                to: droneModel.enemyDroneSencePosition
                duration: 1000
                easing.type: Easing.InBack
                //loops: Animation.Infinite
                onFinished: {
                    droneModel.resetDrone();
                }
            }

            //! [ball strike animations]

            //! [ball animations]
            ParallelAnimation {
                id: ballAnimation
                running: false
                // Move forward
                NumberAnimation {
                    target: droneModel
                    property: "z"
                    duration: droneModel.speed
                    to: -droneModel.directionY * 5
                    easing.type: Easing.OutQuad
                }
                // Move up & down with a bounce
                SequentialAnimation {
                    NumberAnimation {
                        target: droneModel
                        property: "y"
                        duration: droneModel.speed * (1 / 3)
                        to: droneModel.y + droneModel.directionY
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: droneModel
                        property: "y"
                        duration: droneModel.speed * (2 / 3)
                        to: mainWindow.droneSize / 4
                        easing.type: Easing.OutBounce
                    }
                }
                // Move sideways
                NumberAnimation {
                    target: droneModel
                    property: "x"
                    duration: droneModel.speed
                    to: droneModel.x + droneModel.directionX
                }

                onFinished: {
                    if (mainWindow.currentBalls <= 0)
                        view3D.endGame();
                    droneModel.resetDrone();
                }
            }

            NumberAnimation on eulerRotation.z {
                running: droneModel.ballMoving
                loops: Animation.Infinite
                from: droneModel.directionX < 0 ? 0 : 720
                to: 360
                duration: 10000 / (2 + Math.abs(droneModel.directionX * 0.05))
            }
            //! [ball animations]

            //! [ball collisions]
            onZChanged: {
                // Loop through target items and detect collisions
                var hitMargin = mainWindow.droneSize / 2 + mainWindow.targetSize / 2;
                for (var i = 0; i < targetsNode.targets.length; ++i) {
                    var target = targetsNode.targets[i];
                    var targetPos = target.scenePosition;
                    var hit = droneModel.scenePosition.fuzzyEquals(targetPos, hitMargin);
                    if (hit) {
                        target.hit();
                        if (targetsNode.currentTargets <= 0)
                            view3D.nextLevel();

                    }
                }
            }
            //! [ball collisions]
        }

        //! [targets node]
        Node {
            id: targetsNode

            property var targets: []
            property int currentTargets: 0

            function addTargets(items) {
                items.forEach(function (item) {
                    let instance = targetComponent.createObject(
                            targetsNode, { "x": item.x, "startPosY": item.y, "z": item.z, "points": item.points});
                    targets.push(instance);
                });
                currentTargets = targets.length;
            }

            function removeTarget(item) {
                var index = targets.indexOf(item);
                targets.splice(index, 1);
                currentTargets = targets.length;
            }

            function resetTargets() {
                while (targets.length > 0)
                    targets.pop().destroy();
                currentTargets = targets.length;
            }
        }
        //! [targets node]

        //! [target component]
        Component {
            id: targetComponent
            Node {
                id: targetNode

                property int points: 0
                property real hide: 0
                property real startPosY: 0
                property real posY: 0
                property real pointsOpacity: 0

                function hit() {
                    targetsNode.removeTarget(this);
                    mainWindow.score += points;
                    hitAnimation.start();
                    var burstPos = targetNode.mapPositionToScene(Qt.vector3d(0, 0, 0));
                    hitParticleEmitter.burst(100, 200, burstPos);
                }

                y: startPosY + posY
                SequentialAnimation {
                    running: mainWindow.gameOn && !hitAnimation.running
                    loops: Animation.Infinite
                    NumberAnimation {
                        target: targetNode
                        property: "posY"
                        from: 0
                        to: 150
                        duration: 3000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: targetNode
                        property: "posY"
                        to: 0
                        duration: 1500
                        easing.type: Easing.InOutQuad
                    }
                }

                SequentialAnimation {
                    id: hitAnimation
                    NumberAnimation {
                        target: targetNode
                        property: "hide"
                        to: 1
                        duration: 800
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: targetNode
                        property: "pointsOpacity"
                        to: 1
                        duration: 1000
                        easing.type: Easing.InOutQuad
                    }
                    NumberAnimation {
                        target: targetNode
                        property: "pointsOpacity"
                        to: 0
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                    ScriptAction {
                        script: targetNode.destroy();
                    }
                }

                Drones {
                    id: targetModel

                    readonly property real targetScale: (1 + targetNode.hide) * (mainWindow.targetSize / 100)

                    //source: "#Cube"
                    scale: Qt.vector3d(targetScale, targetScale, targetScale)
                    opacity: 0.99 - targetNode.hide * 2
                    // materials: DefaultMaterial {
                    //     diffuseMap: Texture {
                    //         source: "images/qt_logo.jpg"
                    //     }
                    //     normalMap: Texture {
                    //         source: "images/qt_logo_n.jpg"
                    //     }
                    //     bumpAmount: 1.0
                    // }
                    Vector3dAnimation on eulerRotation {
                        loops: Animation.Infinite
                        duration: 5000
                        from: Qt.vector3d(0, 0, 0)
                        to: Qt.vector3d(1, 360, 1)
                    }
                }

                Text {
                    anchors.centerIn: parent
                    scale: 1 + targetNode.pointsOpacity
                    opacity: targetNode.pointsOpacity
                    text: targetNode.points
                    font.pixelSize: 60 * mainWindow.px
                    color: "#808000"
                    style: Text.Outline
                    styleColor: "#f0f000"
                }
            }
        }
        //! [target component]

        //! [ground model]
        Model {
            source: "#Rectangle"
            scale: Qt.vector3d(55, 40, 1)
            eulerRotation.x: -90
            materials: DefaultMaterial {
                diffuseMap: Texture {
                    source: "images/grass.jpg"
                    tilingModeHorizontal: Texture.Repeat
                    tilingModeVertical: Texture.Repeat
                    scaleU: 10.0
                    scaleV: 10.0
                }
                normalMap: Texture {
                    source: "images/grass_n.jpg"
                }
                bumpAmount: 0.1
            }
        }
        //! [ground model]

        //! [sky model]
        Model {
            id: sky
            property real scaleX: 100
            property real scaleY: 20
            source: "#Rectangle"
            scale: Qt.vector3d(sky.scaleX, sky.scaleY, 1)
            position: Qt.vector3d(0, 960, -2000)
            // We don't want shadows casted into sky
            receivesShadows: false
            materials: DefaultMaterial {
                diffuseMap: Texture {
                    source: "images/sky.jpg"
                }
            }
            // Star particles
            Node {
                z: 500
                y: 30
                // Stars are far away, scale up to half the resolution
                scale: Qt.vector3d(2 / sky.scaleX, 2 / sky.scaleY, 1)
                ParticleSystem {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    width: 3000
                    height: 400
                    ImageParticle {
                        source: "qrc:///particleresources/star.png"
                        rotationVariation: 360
                        color: "#ffffa0"
                        colorVariation: 0.1
                    }
                    Emitter {
                        anchors.fill: parent
                        emitRate: 4
                        lifeSpan: 6000
                        lifeSpanVariation: 4000
                        size: 30
                        sizeVariation: 20
                    }
                }
            }
        }
        //! [sky model]

        //! [hit particles]
        ParticleSystem3D {
            id: psystem
            SpriteParticle3D {
                id: sprite3D
                sprite: Texture {
                    source: "images/particle.png"
                }
                color: Qt.rgba(1.0, 1.0, 0.0, 1.0)
                colorVariation: Qt.vector4d(0.4, 0.6, 0.0, 0.0)
                unifiedColorVariation: true
                maxAmount: 200
            }
            ParticleEmitter3D {
                id: hitParticleEmitter
                particle: sprite3D
                particleScale: 4.0
                particleScaleVariation: 2.0
                particleRotationVariation: Qt.vector3d(0, 0, 180)
                particleRotationVelocityVariation: Qt.vector3d(0, 0, 250)
                velocity: VectorDirection3D {
                    direction: Qt.vector3d(0, 300, 0)
                    directionVariation: Qt.vector3d(200, 150, 100)
                }
                lifeSpan: 800
                lifeSpanVariation: 200
                depthBias: 100
            }
            Gravity3D {
                magnitude: 600
            }
        }
        //! [hit particles]

        Component.onCompleted: {
            view3D.initGameLevels();
        }
    }
    // Game time counter
    NumberAnimation {
        id: gameTimeAnimation
        target: mainWindow
        property: "currentTime"
        running: mainWindow.gameOn
        duration: mainWindow.gameTime * 1000
        from: mainWindow.gameTime
        to: 0
        onFinished: {
            view3D.endGame();
        }
    }

    // Show time, balls and score
    Item {
        width: parent.width
        height: 60 * mainWindow.px
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            text: mainWindow.currentTime.toFixed(2)
        }
        Image {
            id: ballImg
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1 * mainWindow.px
            anchors.right: ballCountText.left
            anchors.rightMargin: 8 * mainWindow.px
            width: 26 * mainWindow.px
            height: width
            mipmap: true
            source: "images/drone_icon.png"
        }
        Text {
            id: ballCountText
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            text: mainWindow.currentBalls
        }
        Text {
            anchors.centerIn: parent
            font.pixelSize: 36 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            text: mainWindow.score
        }
        Text {
            id: levelLabText
            text: "Level:"
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: levelText.left
            anchors.rightMargin: 20 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
        }
        Text {
            id: levelText
            text: mainWindow.currentLevel
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: ballImg.left
            anchors.rightMargin: 20 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
        }
    }

    // Game logo
    Image {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.6, sourceSize.width)
        height: width * 0.6
        fillMode: Image.PreserveAspectFit
        source: mainWindow.gameStateTipImg
        opacity: !mainWindow.gameOn
        scale: 2.0 - opacity
        Behavior on opacity {
            NumberAnimation {
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }
    }

    // Show bonus and total score when the game ends
    Item {
        property bool show: mainWindow.playingStarted && !mainWindow.gameOn

        anchors.centerIn: parent
        anchors.verticalCenterOffset: -200 * mainWindow.px
        onShowChanged: {
            if (show) {
                showScoreAnimation.start();
            } else {
                showScoreAnimation.stop();
                timeBonusText.opacity = 0;
                ballsBonusText.opacity = 0;
                totalScoreText.opacity = 0;
            }
        }

        SequentialAnimation {
            id: showScoreAnimation
            NumberAnimation {
                target: timeBonusText
                property: "opacity"
                to: 1
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: ballsBonusText
                property: "opacity"
                to: 1
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: totalScoreText
                property: "opacity"
                to: 1
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }

        Text {
            id: timeBonusText
            anchors.horizontalCenter: parent.horizontalCenter
            y: opacity * 60 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            textFormat: Text.StyledText
            text: qsTr("TIME BONUS <b>%1</b>").arg(mainWindow.timeBonus)
            opacity: 0
        }
        Text {
            id: ballsBonusText
            anchors.horizontalCenter: parent.horizontalCenter
            y: timeBonusText.y + opacity * 40 * mainWindow.px
            font.pixelSize: 26 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            textFormat: Text.StyledText
            text: qsTr("DRONES BONUS <b>%1</b>").arg(mainWindow.ballsBonus)
            opacity: 0
        }
        Text {
            id: totalScoreText
            anchors.horizontalCenter: parent.horizontalCenter
            y: ballsBonusText.y + opacity * 60 * mainWindow.px
            font.pixelSize: 66 * mainWindow.px
            color: "#ffffff"
            style: Text.Outline
            styleColor: "#000000"
            textFormat: Text.StyledText
            text: qsTr("SCORE <b>%1</b>").arg(mainWindow.score + mainWindow.timeBonus + mainWindow.ballsBonus)
            opacity: 0
        }
    }

    RoundButton {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40 * mainWindow.px
        width: 140 * mainWindow.px
        height: 60 * mainWindow.px
        visible: !mainWindow.gameOn
        font.pixelSize: 26 * mainWindow.px
        text:mainWindow.gameStateText
        onClicked: {
            view3D.startGame();
        }
    }
    // WasdController {
    //     controlledObject: droneNode

    // }
    DebugView {
        anchors.left: parent.Left
        anchors.bottom: parent.bottom
        source: view3D
    }
}
