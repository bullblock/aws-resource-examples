import requests

# URL of the file
url = "https://raw.githubusercontent.com/bullblock/aws-acm-certs/refs/heads/main/client.paraview.biz.crt"

# Fetching the file content
response = requests.get(url)

# Checking if the request was successful
if response.status_code == 200:
    # Printing the content of the file
    print(response.text)
else:
    print(f"Failed to fetch the file. Status code: {response.status_code}")
