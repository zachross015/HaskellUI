{-# LANGUAGE DeriveDataTypeable #-}

-- TODO: Convert to having a   `property` JSON for every Viewable part

module HaskellUI.Property 
    (
    Property (..),
    -- StyleProperty (..),
    Direction (..),
    alignment,
    className, 
    foregroundColor,
    renderProperties
    ) where 

import Data.Char
import Data.Data 
import Data.Function (on)
import Data.List (groupBy)

import HaskellUI.WebMeasurement
import HaskellUI.Color

-- MARK: CSS Definition

type AttributeProperty = (String, String)

data Direction = Leading | Trailing | Top | Bottom | Center
instance Show Direction where 
    show Leading = "left"
    show Trailing = "right"
    show Top = "top"
    show Bottom = "bottom"
    show Center = "center"

data Property = Style AttributeProperty | Class String | Attribute AttributeProperty

-- Aid function for `renderProperties`
renderProperty :: (String, String, String) -> Property -> (String, String, String)
renderProperty (styles, attrs, classes) (Style (a, b)) = (styles ++ a ++ ": " ++ b ++ "; ", attrs, classes)
renderProperty (styles, attrs, classes) (Class s) = (styles, attrs, classes ++ s ++ " ")
renderProperty (styles, attrs, classes) (Attribute (a, b)) = (styles, attrs ++ a ++ "='" ++ b ++ "' ", classes)

-- Aid function for `renderProperties`
putTogetherAttributes :: (String, String, String) -> String 
putTogetherAttributes (styles, attrs, classes) = "style='" ++ styles ++ "' " ++ attrs ++ "class='" ++ classes ++ "'"

renderProperties :: [Property] -> String 
renderProperties p = putTogetherAttributes $ foldl renderProperty ("", "", "") p
          

className :: String -> Property 
className = Class 

alignment :: Direction -> Property 
alignment x = Style ("float", show x)

foregroundColor :: RGB -> Property 
foregroundColor color = Style ("color", "rgb" ++ show color)