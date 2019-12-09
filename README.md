# Retrofire

Retro iOS game: endless runner/shooter with tilt controls, player unlocks and ad integration. Approved on the app store 2018. Requires iOS 10+.

This software is licensed under the MIT software license (see LICENSE file). Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

The author of this software makes no representation or guarantee that this software (including any third-party libraries) will perform as intended or will be free of errors, bugs or faulty code. The software may fail which could completely or partially limit functionality or compromise computer systems. If you use or implement the software, you do so at your own risk. In no event will the author of this software be liable to any party for any damages whatsoever, even if it had been advised of the possibility of damage.

### Gameplay
The player drives a tank, holding off flying enemies while navigating terrain.
Steering is done using device tilt and the player can shoot the tank's weapons by tapping the screen.
Enemies include biplanes, bombers and zeppelins.
Collisions with dangerous objects damage the player's tank.
The player has three lives, the game tracks high score and doing well unlocks vehicles with different handling/appearance.


### Technical details
The front end is implemented with Swift using Apple's SpriteKit.
Core functionality uses Objective-C.
The procedural generation is mixed: dynamic positioning of a static object set.
Ad integration is done with the Google Mobile Ads API for iOS.
All artwork was hand-painted and special effects are programmatic.
