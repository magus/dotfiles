#!/bin/bash

set -e

export AWS_ACCESS_KEY_ID=$(cat ~/.aws/keys/access)
export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/keys/secret)
export AWS_DEFAULT_REGION=us-west-2

export EC2_SECURITY_GROUP_ID=$(cat ~/.aws/keys/sgid)

# Get the current lowest price for the GPU machine we want (we'll be bidding a cent above)
echo -n "Getting lowest g2.2xlarge bid... "
PRICE=$( aws ec2 describe-spot-price-history --instance-types g2.2xlarge --product-descriptions "Windows" --start-time `date +%s` | jq --raw-output '.SpotPriceHistory[].SpotPrice' | sort | head -1 )
echo $PRICE

echo -n "Looking for the ec2-gaming AMI... "
AMI_SEARCH=$( aws ec2 describe-images --owner self --filters Name=name,Values=ec2-gaming )
if [ $( echo "$AMI_SEARCH" | jq '.Images | length' ) -eq "0" ]; then
	echo "not found. You must use gaming-down.sh after your machine is in a good state."
	exit 1
fi
AMI_ID=$( echo $AMI_SEARCH | jq --raw-output '.Images[0].ImageId' )
echo $AMI_ID

echo -n "Creating spot instance request... "
SPOT_INSTANCE_ID=$( aws ec2 request-spot-instances --spot-price $( bc <<< "$PRICE + 0.01" ) --launch-specification "
  {
    \"SecurityGroupIds\": [\"$EC2_SECURITY_GROUP_ID\"],
    \"ImageId\": \"$AMI_ID\",
    \"InstanceType\": \"g2.2xlarge\"
  }" | jq --raw-output '.SpotInstanceRequests[0].SpotInstanceRequestId' )
echo $SPOT_INSTANCE_ID

echo -n "Waiting for instance to be launched... "
aws ec2 wait spot-instance-request-fulfilled --spot-instance-request-ids "$SPOT_INSTANCE_ID"

INSTANCE_ID=$( aws ec2 describe-spot-instance-requests --spot-instance-request-ids "$SPOT_INSTANCE_ID" | jq --raw-output '.SpotInstanceRequests[0].InstanceId' )
echo "$INSTANCE_ID"

echo "Removing the spot instance request..."
aws ec2 cancel-spot-instance-requests --spot-instance-request-ids "$SPOT_INSTANCE_ID" > /dev/null

echo -n "Getting ip address... "
IP=$( aws ec2 describe-instances --instance-ids "$INSTANCE_ID" | jq --raw-output '.Reservations[0].Instances[0].PublicIpAddress' )
echo "$IP"

echo "Waiting for server to become available..."
while ! ping -c1 $IP &>/dev/null; do sleep 5; done

echo "All done!"
