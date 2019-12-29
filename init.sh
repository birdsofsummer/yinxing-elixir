# https://hexdocs.pm/phoenix/up_and_running.html
# https://www.postgresql.org/docs/12/tutorial-createdb.html
# https://www.postgresql.org/docs/12/tutorial-table.html







name="yinxing_e"

######################################ssl###############################################################

pass=111111
priv=selfsigned_key.pem
pub=rsa_public.key
cert=selfsigned.pem

mkdir -p priv/cert
cd priv/cert

openssl genrsa -aes256 -passout pass:$pass -out $priv 2048
openssl rsa -in $priv -passin pass:$pass -pubout -out $pub
openssl req -new -x509 -days 365 -key $priv -out $cert

##############################################pg-server###################################################
su - postgres
postgres
##############################################pg-client###################################################
su - postgres
psql
#/usr/local/pgsql/bin/createdb YinxingE.Repo
db=YinxingE.Repo
createdb $db
#dropdb  $db
psql $db
\?
\h
\q

# SELECT version();
# SELECT current_date;
# SELECT 2 + 2;
#...

#################################################################################################

mix phx.new $name
#Fetch and install dependencies? [Yn] n
cd $name
mix deps.get


#################################################################################################
cd assets && cnpm install && node node_modules/webpack/bin/webpack.js --mode development
#################################################################################################

#config/dev.exs
mix ecto.create
mix phx.server
#iex -S mix phx.server
#http://127.0.0.1:4000
