module Page.Note exposing (Message, Model, init, subscriptions, update, view)

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as A
import Html.Styled.Events as A



--Model


type alias Model =
    { text : String
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { text = "Dashboard" }
    , Cmd.none
    )



-- Type Messages


type Message
    = EditNote String
    | SaveNote
    | DeleteNote
    | NoOp



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        EditNote newText ->
            ( { model | text = newText }, Cmd.none )

        SaveNote ->
            ( model, Cmd.none )

        DeleteNote ->
            ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )



--SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



--VIEW


view : Model -> Html Message
view model =
    styled div
        [ fontSize (px 44)
        , fontWeight (int 600)
        ]
        [ A.onClick
            (EditNote "My notes")
        ]
        [ text model.text ]


noteListStyle : List Style
noteListStyle =
    [ fontSize (px 44)
    , fontWeight (int 600)
    ]
