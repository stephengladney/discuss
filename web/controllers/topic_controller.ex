defmodule Discuss.TopicController do
    use Discuss.Web, :controller
    alias Discuss.Topic

    def index(conn, _params) do
        topics = Repo.all(Topic) |> Enum.reverse()
        render conn, "index.html", topics: topics
    end

    def new(conn, _params) do
        render conn, "new.html", changeset: Topic.changeset(%Topic{}, %{})
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, post} -> 
                conn
                |> put_flash(:info, "Topic created!")
                |> redirect(to: topic_path(conn, :index))
                # render conn, "index.html", topics: Repo.all(Topic)
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error creating the topic.") 
                render "new.html", changeset: changeset
        end
    end

    
end