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
            {:ok, _topic} -> 
                conn
                |> put_flash(:info, "Topic created!")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error creating the topic.") 
                render "new.html", changeset: changeset
        end
    end

    def edit(conn, %{"id" => id}) do
        topic = Repo.get(Topic, id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    def update(conn, %{"id" => id, "topic" => topic}) do
        old_topic = Repo.get(Topic, id)
        changeset = Topic.changeset(old_topic, topic)

        case Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic updated!")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, topic: old_topic
        end
    end


    
end