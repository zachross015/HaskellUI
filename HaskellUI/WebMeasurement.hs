{-# LANGUAGE DeriveDataTypeable #-}

module HaskellUI.WebMeasurement (WebMeasurement (..)) where

import Data.Data
import Data.Typeable
import Data.Char

data WebMeasurement = 
    Px | 
    In | 
    Cm | 
    Mm | 
    Pt | 
    Pc | 
    Em | 
    Ex | 
    Ch | 
    Rem | 
    Vw | 
    Vh | 
    Vmin | 
    Vmax | 
    Percent
    deriving (Typeable, Data)

instance Show WebMeasurement where 
    show Percent = "%"
    show x = map toLower . show $ toConstr x