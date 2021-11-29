  echo "Adding the dynatrace url and enabling the istio to the custom resource yaml file"
  wget $CUSTOM_RESOURCE  && sed -i 's/# enableIstio: false/enableIstio: true/g;s/ENVIRONMENTID/cwj81565/g' cr.yaml
  sleep 5
	kubectl apply -f cr.yaml
