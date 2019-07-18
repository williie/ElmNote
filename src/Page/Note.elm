module Page.Note exposing (Message, Model, init, subscriptions, update, view)

import Array exposing (Array)
import Browser
import Css exposing (..)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events as A exposing (onClick)



--Model


type alias Model =
    { title : String
    , content : String
    , id : Int
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { title = "My first Note", content = "This is my first Note", id = 1 }
    , Cmd.none
    )



-- Type Messages


type Message
    = AddNote
    | EditNote String
    | SaveNote
    | DeleteNote
    | NoOp



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AddNote ->
            ( model, Cmd.none )

        DeleteNote ->
            ( model, Cmd.none )

        EditNote newText ->
            ( { model | content = newText }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        SaveNote ->
            ( model, Cmd.none )



--SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



--VIEW


view : Model -> Html Message
view model =
    div []
        [ button [ class "btn btn-primary", onClick AddNote ] [ text "Add new note" ]
        , button [ class "btn btn-danger", onClick SaveNote ] [ text "Save note" ]
        , div
            [ A.onClick
                (EditNote "Note was edited")
            ]
            [ text model.content ]
        ]


noteListStyle : List Style
noteListStyle =
    [ fontSize (px 44)
    , fontWeight (int 600)
    ]
