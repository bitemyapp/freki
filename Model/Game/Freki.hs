module Model.Game.Freki where

import Data.Angle

data Model = Model { stats          :: ModelStats
                   , focus          :: Integer
                   , damage         :: DamageModel
                   , fieldAllowance :: FieldAllowance
                   , baseSize       :: BaseSize
                   , armyCost       :: ArmyCost
                   , feat           :: Feat
                   , actions        :: [Action] } deriving (Show)

data ModelStats = ModelStats { speed        :: Rational
                             , strength     :: Integer
                             , meleeAttack  :: Integer
                             , rangedAttack :: Integer
                             , defense      :: Integer
                             , armor        :: Integer
                             , command      :: Integer } deriving (Show)

-- Action/Movement "attempts" or possibilities

data Feat = Feat String deriving (Show)

data Spell = Spell { name        :: String
                   , description :: String
                   , cost        :: SpellCost
                   , range       :: SpellRange
                   , aoe         :: Maybe AOE
                   , power       :: Maybe Integer
                   , upkeep      :: Bool
                   , offense     :: Bool } deriving (Show)

data SpellCost = SpellCost Int | SpellCostStar deriving (Show)
data AOE = AoeControl | AOE Integer deriving (Show)
data SpellRange = SpellRangeSelf | SpellRangeControl | Range Integer deriving (Show)

data Action = RangedAttack | MeleeAttack | FeatAction Feat | Ability | SpellAction Spell | Standup deriving (Show)

data Movement = Movement { direction :: Integer, radius :: Radians Rational } deriving (Show)

data DamageModel = HumanHealth | Armor | ShieldedArmor deriving (Show)

data FieldAllowance = C | U | FA Integer deriving (Show)

data BaseSize = SmallBase | MediumBase | LargeBase | HugeBase deriving (Show)

data ArmyCost = PointCost Integer | WarjackPoints Integer deriving (Show)

-- Events

data GameState = GameState Int deriving (Show)

data Event = Event String deriving (Show)

resolveEvent :: (GameState, [Event]) -> (GameState, [Event])
resolveEvent ((GameState 0), []) = ((GameState 0), [])
resolveEvent ((GameState n), []) = ((GameState n), [])
resolveEvent ((GameState 0), ((Event name) : xs)) = ((GameState 0), xs)
resolveEvent ((GameState n), ((Event name) : xs)) = (GameState (n-1), xs ++ (replicate n $ Event name))
