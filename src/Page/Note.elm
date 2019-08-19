module Page.Note exposing (Message, Model, init, subscriptions, update, view)

import Css exposing (..)
import Html exposing (Html, button, div, input, label, li, ol, text)
import Html.Attributes exposing (class, value)
import Html.Events as A exposing (onClick, onInput)
import List.Extra as List


type alias Note =
    { title : String
    , content : String
    , noteId : Int
    }



--Model


type alias Model =
    { notes : List Note
    , selectedNote : Int
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { notes = []
      , selectedNote = 0
      }
    , Cmd.none
    )



-- Type Messages


type Message
    = AddNote
    | EditNote String Int
    | DeleteNote
    | NoOp
    | SaveNote
    | SelectNote Int



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AddNote ->
            let
                newNoteId =
                    List.length model.notes
            in
            ( { model | selectedNote = newNoteId, notes = [ { title = "My Note " ++ String.fromInt newNoteId, content = "This is my new note", noteId = newNoteId } ] ++ model.notes }, Cmd.none )

        DeleteNote ->
            ( model, Cmd.none )

        EditNote text id ->
            --List.map Apply a function to every element of a list.
            ( { model | selectedNote = id, notes = List.map (\note -> { note | title = text }) model.notes }, Cmd.none )

        -- ( { model | notes = List.map (\note -> { note | noteId = id }) model.selectedNote = id }, Cmd.none )
        NoOp ->
            ( model, Cmd.none )

        SaveNote ->
            ( model, Cmd.none )

        SelectNote id ->
            ( { model | selectedNote = id }, Cmd.none )



--SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



--VIEW


view : Model -> Html Message
view model =
    div []
        [ button [ class "btn btn-primary", onClick AddNote ]
            [ text "Add new note" ]
        , button [ class "btn btn-danger", onClick DeleteNote ] [ text "Delete note" ]
        , div [] [ text "My Note App" ]
        , div [ class "note-container" ] [ renderList model ]
        , div [ class "form-group" ] [ renderForm model ]

        -- , div
        --   [ onClick
        --     (EditNote "Hello" model.selectedNote)
        --]
        --[ text "Note was edited" ]
        ]


renderList : Model -> Html Message
renderList model =
    model.notes
        |> List.map
            (\l ->
                div []
                    [ li
                        []
                        [ text "#Title: "
                        , text l.title
                        ]
                    , div []
                        [ text l.content
                        ]
                    ]
            )
        |> ol []


renderForm : Model -> Html Message
renderForm model =
    div []
        [ label
            []
            [ text "Title " ]
        , input
            [ onInput (\x -> EditNote x 1) ]
            []
        , label
            []
            [ text " Content" ]
        , input
            [ onInput (\x -> EditNote x 1) ]
            []
        ]



--|> List.indexedMap (\index selectedNote -> li [] [ text selectedNote.title ])
--|> ul []
