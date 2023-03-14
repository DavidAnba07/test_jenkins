export token=$(curl --location 'https://xray.cloud.getxray.app/api/v2/authenticate' \
--header 'Content-Type: application/json' \
--data '{
    "client_id": "ACB6E49CA6C24E178A0AEB331D176B5F",
    "client_secret": "91080ee36fe40593e52989031803984f5f7711246fa0400b13fa39d7bb8ac72f"
}'| tr -d '"' )

echo $token>token.txt

export creacion=$(curl --location "https://xray.cloud.getxray.app/api/v2/import/execution/cucumber/multipart" \
--header "Authorization: Bearer $token" \
--header 'Content-Type: multipart/form-data' \
--form info=@"/C:/Users/David.Barcia/Desktop/Documentos/info.json" \
--form results=@"/C:/Users/David.Barcia/Desktop/Documentos/Cucumberprueba.json")

echo $creacion>crear.txt

export key=$(grep "IXR" crear.txt | cut -d '"' -f 8)

echo "Imprimiendo key : " $key
export url="https://integracionx-ray.atlassian.net/rest/api/3/issue/${key}/attachments"
curl --location -g $url \
--header 'X-Atlassian-Token: no-check' \
--header 'Authorization: Basic ZGF2aWQuYmFyY2lhQHRzb2Z0bGF0YW0uY29tOkFUQVRUM3hGZkdGMHd1R0poN0RBM2lULUtPbm41clM2LUJzTmFFWmRzUlA4R0dfNFFVdnM4UFZ5Z000VmVLbDc1dko4WWtJdUh2RXB4YTdLRDJxSEdoZG1kU203LWpDb0RkWElRRWtDb1JjVm15OTRBQnVHcnRfSFB3elE4ZXFLak8zY3lrUjU0bVVza3NiZS03OFZkdHpZZFZma2lNWVdHLVRQNWZ1NUozVTdIakZqX3YwMm9fZz1CQTI4Rjk4Ng==' \
--form file=@"/C:/Users/David.Barcia/Downloads/reporteQA.pdf"
