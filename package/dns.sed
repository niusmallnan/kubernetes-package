s/$DNS_SERVER_IP/10.43.0.10/g
s/$DNS_REPLICAS/2/g
s/$DNS_DOMAIN/cluster.local/g
/        - --dns-port=10053/a \
        - --kube-master-url=http://kubernetes.kubernetes:80
s/gcr.io\/google_containers/registry.cn-hangzhou.aliyuncs.com\/google-containers/g
