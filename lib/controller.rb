require "gossip"

class ApplicationController < Sinatra::Base
  get "/" do
    erb :index, locals: { gossips: Gossip.all }
  end

  get "/gossips/new/" do
    erb :new_gossip
  end

  post "/gossips/new/" do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    # puts "Ceci est le contenu du hash params : #{params}"
    # puts "Ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
    # puts "Ceci est ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
    redirect "/"
  end

  get "/gossips/:id/" do
    id = params[:id].to_i
    gossip = Gossip.find(id)
    erb :show, locals: { gossip: gossip }
  end

  get "/gossips/:id/edit/" do
    gossip = Gossip.find(params["id"])
    id = params["id"].to_i
    erb :edit, locals: { gossip: gossip, id: id }
  end

  post "/gossips/:id/" do
    id = params[:id].to_i
    author = params[:author]
    content = params[:content]
    Gossip.update(id, author, content)
    redirect "/"
  end

  run! if app_file == $0
end
