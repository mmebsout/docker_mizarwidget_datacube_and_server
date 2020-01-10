read -s -p "Enter DockerHub idocias password: " idociaspassword

echo $idociaspassword  | docker login --username=idocias --password-stdin
docker push idocias/datacube-and-server:latest

source publishReadme.sh

echo "idocias/datacube-and-server:latest published!"