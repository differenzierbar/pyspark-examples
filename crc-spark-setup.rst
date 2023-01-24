Spark setup on crc
==================

Setup steps:: 
    
    oc login -u developer https://api.crc.testing:6443
    oc new-project spark
    oc create serviceaccount spark
    oc create rolebinding spark-role --clusterrole=edit --serviceaccount=spark:spark --namespace=spark
    podman run --user $UID --userns=keep-id -v ~/.kube/config:/opt/spark/work-dir/.kube/config -it docker.io/apache/spark-py /opt/spark/bin/spark-submit --deploy-mode cluster --master k8s://api.crc.testing:6443 --conf "spark.kubernetes.namespace=spark" --conf "spark.kubernetes.driver.container.image=apache/spark-py:v3.3.1" --conf "spark.kubernetes.executor.container.image=apache/spark-py:v3.3.1" --conf "spark.kubernetes.authenticate.driver.serviceAccountName=spark" local:///opt/spark/examples/src/main/python/pi.py 10


