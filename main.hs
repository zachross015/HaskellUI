
import HaskellUI.View
import HaskellUI.Property
import HaskellUI.Color 
import HaskellUI.WebMeasurement

-- Testing



html :: (View a) => a -> String
html obj = 
    "<!DOCTYPE HTML><html><head><link rel='stylesheet' href='reset.css'><link rel='stylesheet' href='style.css'></head><body><div id='body'>" 
    ++ render obj ++
    "</div></body></html>"

main = writeFile "index.html" $ html $   
    vstack [ 
        text "Hello World", 
        hstack [ 
            text "Goodbye world", 
            text "mmm" <| [foregroundColor blue] 
        ] <| [foregroundColor red], text("things") 
    ] <| [alignment Leading]