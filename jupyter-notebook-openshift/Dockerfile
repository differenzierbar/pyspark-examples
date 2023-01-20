FROM jupyter/pyspark-notebook:spark-3.3.1

USER 0

# downgrade to python 3.9 to be compatible https://hub.docker.com/r/apache/spark-py 
RUN conda install python=3.9

USER 1000