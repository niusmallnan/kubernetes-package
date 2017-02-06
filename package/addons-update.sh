#!/bin/bash
set -e -x

if [ ${DISABLE_ADDONS} == "true" ]; then
    echo "addons have been disabled"
    sleep infinity
fi

while ! kubectl --kubeconfig=/etc/kubernetes/ssl/kubeconfig --namespace=kube-system get ns kube-system >/dev/null 2>&1; do
#  echo "Waiting for kubernetes API to come up..."
  sleep 2
done

cat > /tmp/rancher-service-account.yaml << EOF
apiVersion: v1
kind: ServiceAccount
metadata:
      name: "io-rancher-system"
      namespace: "kube-system"
EOF

kubectl --kubeconfig=/etc/kubernetes/ssl/kubeconfig create -f /tmp/rancher-service-account.yaml || true 

for f in $(find /etc/kubernetes/addons -regex '.*\.yaml\|.*\.yml'); do
  kubectl --kubeconfig=/etc/kubernetes/ssl/kubeconfig --namespace=kube-system replace --force -f ${f}
done

sleep infinity
