module Route exposing (Route(..), fromUrl, parser)

import Url
import Url.Parser as P


type Route
    = Note


parser : P.Parser (Route -> a) a
parser =
    P.oneOf
        [ P.map Note <|
            P.top
        ]


fromUrl : Url.Url -> Maybe Route
fromUrl =
    P.parse parser
