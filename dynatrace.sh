aws eks update-kubeconfig --name $EKS_CLUSTERNAME --region $AWS_REGION
namespace=`kubectl get ns | awk '{print $1}'| grep -i dynatrace`

if [ "$namespace" = "dynatrace" ]
then
    echo "dynatrace namespace, oneagent, activegate, custom resource is already installed"
else
	echo "Installation of active gate"
	wget $ACTIVEGATE_URL -O install.sh && sh ./install.sh --api-url "$DYNATRACE_URL" --api-token "$API_TOKEN" --paas-token "$PASS_TOKEN" --cluster-name "$EKS_CLUSTERNAME"
	sleep 10
	
    echo "Installation of  oneagent in kubernetes cluster"
	kubectl apply -f $ONEAGENT_URL
	sleep 5
	
	echo "Adding the secrets i.e. api token and pass token"
    kubectl -n dynatrace create secret generic oneagent --from-literal="apiToken=$API_TOKEN" --from-literal="paasToken=$PASS_TOKEN"
    
	echo "Adding the dynatrace url and enabling the istio to the custom resource yaml file"
    curl -o cr.yaml $CUSTOM_RESOURCE
    sed -i 's/# enableIstio: false/ enableIstio: true/g;s/ENVIRONMENTID/cwj81565/g' cr.yaml
	kubectl apply -f cr.yaml
fi
