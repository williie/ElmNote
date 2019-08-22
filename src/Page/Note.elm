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
    , selectedNote : Maybe Note
    }



--INIT


init : ( Model, Cmd Message )
init =
    ( { notes = []
      , selectedNote = Nothing
      }
    , Cmd.none
    )



-- Type Messages


type Message
    = AddNote
    | Cancel
    | DeleteNote Note
    | EditTitle String
    | EditContent String
    | NoOp
    | SaveNote
    | SelectNote Note



--UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        AddNote ->
            let
                newNoteId =
                    List.length model.notes
            in
            ( { model | selectedNote = Nothing, notes = [ { title = "My Note " ++ String.fromInt newNoteId, content = "This is my new note", noteId = newNoteId } ] ++ model.notes }, Cmd.none )

        Cancel ->
            ( { model | selectedNote = Nothing }, Cmd.none )

        DeleteNote myNote ->
            let
                newList =
                    List.removeAt myNote.noteId model.notes
            in
            ( { model | notes = newList }, Cmd.none )

        EditTitle text ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just myNote ->
                    ( { model | selectedNote = Just { myNote | title = text } }, Cmd.none )

        EditContent text ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just myNote ->
                    ( { model | selectedNote = Just { myNote | content = text } }, Cmd.none )

        SaveNote ->
            case model.selectedNote of
                Nothing ->
                    ( model, Cmd.none )

                Just myNote ->
                    let
                        newList =
                            List.setAt myNote.noteId myNote model.notes
                    in
                    ( { model | selectedNote = Just myNote, notes = newList }, Cmd.none )

        SelectNote myNote ->
            ( { model | selectedNote = Just myNote }, Cmd.none )

        _ ->
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
        , div [] [ text "My Note App" ]
        , div [ class "form-group" ] [ renderForm model ]
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
                    , button [ onClick (SelectNote l) ] [ text "Select" ]
                    , button [ onClick (DeleteNote l) ] [ text "Delete" ]
                    ]
            )
        |> ol []


renderForm : Model -> Html Message
renderForm model =
    case model.selectedNote of
        Nothing ->
            renderList model

        Just note ->
            div []
                [ label
                    []
                    [ text "Title " ]
                , input
                    [ value note.title
                    , onInput (\x -> EditTitle x)
                    ]
                    []
                , label
                    []
                    [ text " Content" ]
                , input
                    [ value note.content
                    , onInput (\x -> EditContent x)
                    ]
                    []
                , button [ onClick SaveNote ] [ text "Save Note" ]
                , button [ onClick Cancel ] [ text "Cancel " ]
                , renderList model
                ]
