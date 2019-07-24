module Page.Note exposing (Message, Model, init, subscriptions, update, view)

import Css exposing (..)
import Html exposing (Html, button, div, li, text, ul)
import Html.Attributes exposing (class)
import Html.Events as A exposing (onClick)


type alias Note =
    { title : String
    , content : String
    , noteId : Int
    }



--Model


type alias Model =
    { notes : List Note
    , selectedNote : Maybe Int
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { notes =
            [ { title = "My first Note", content = "This is my first note", noteId = 1 }
            , { title = "My second Note", content = "This is my second note", noteId = 2 }
            , { title = "My third Note", content = "This is my third note", noteId = 3 }
            ]
      , selectedNote = Nothing
      }
    , Cmd.none
    )



-- Type Messages


type Message
    = AddNote
    | EditNote String
    | DeleteNote Int
    | NoOp
    | SaveNote
    | SelectNote Int



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AddNote ->
            ( { model | notes = [ { title = "My n-th Note", content = "This is my n-th note", noteId = 4 } ] ++ model.notes, selectedNote = Just 1 }, Cmd.none )

        DeleteNote id ->
            ( model, Cmd.none )

        EditNote newText ->
            ( { model | notes = List.map (\note -> { note | content = newText }) model.notes }, Cmd.none )

        NoOp ->
            ( model, Cmd.none )

        SaveNote ->
            ( model, Cmd.none )

        SelectNote id ->
            ( { model | selectedNote = Just id }, Cmd.none )



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
        , div [ class "note-container" ] [ renderList model ]

        --        , div
        --            [ A.onClick
        --                (EditNote "Note was edited")
        --            ]
        --            [ text "My Notes" ]
        ]


renderList : Model -> Html Message
renderList model =
    model.notes
        |> List.map (\l -> li [] [ text l.content ])
        |> ul []
