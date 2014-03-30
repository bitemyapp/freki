module Model.Game.Freki where

import Data.Angle

data Model = Model { stats          :: ModelStats
                   , focus          :: Integer
                   , damage         :: DamageModel
                   , fieldAllowance :: FieldAllowance
                   , baseSize       :: BaseSize
                   , armyCost       :: ArmyCost
                   , feat           :: Feat String
                   , actions        :: [Action String] } deriving (Show)

data ModelStats = ModelStats { speed        :: Rational
                             , strength     :: Integer
                             , meleeAttack  :: Integer
                             , rangedAttack :: Integer
                             , defense      :: Integer
                             , armor        :: Integer
                             , command      :: Integer } deriving (Show)

-- Action/Movement "attempts" or possibilities

data Feat a = String a deriving (Show)

data Action a = RangedAttack | MeleeAttack | Feat a | Ability | Spell | Standup deriving (Show)

data Movement = Movement { direction :: Integer, radius :: Radians Rational } deriving (Show)

data DamageModel = HumanHealth | Armor | ShieldedArmor deriving (Show)

data FieldAllowance = C | U | FA Integer deriving (Show)

data BaseSize = SmallBase | MediumBase | LargeBase | HugeBase deriving (Show)

data ArmyCost = PointCost Integer | WarjackPoints Integer deriving (Show)
