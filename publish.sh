ead -s -p "Enter DockerHub idocdocker password: " idocdockerpassword

echo $idocdockerpassword  | docker login --username=idocdocker --password-stdin
docker push idocias/mizarwidget-datacube-and-server:latest

source publishReadme.sh

echo "idocias/mizarwidget-datacube-and-server:latest published!"